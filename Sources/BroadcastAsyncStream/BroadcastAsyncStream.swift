//
//  File.swift
//  
//
//  Created by Mikhail Nikanorov on 3/7/24.
//

import Foundation

public struct BroadcastAsyncStream<Element: Sendable>: AsyncSequence, Sendable, Identifiable {
  public typealias AsyncIterator = AsyncStream<Element>.Iterator
  
  public let id = UUID()
  private let stream: Stream<Element>
  private let consumers = ThreadSafe<[UUID: AsyncStream<Element>.Continuation]>([:])
  private let consumersTask = ThreadSafe<Task<Void, Never>?>(nil)
  
  public init(bufferingPolicy limit: AsyncStream<Element>.Continuation.BufferingPolicy = .unbounded) {
    self.init(bufferingPolicy: limit) { _ in }
  }
  
  public init(bufferingPolicy limit: AsyncStream<Element>.Continuation.BufferingPolicy = .unbounded, _ build: (AsyncStream<Element>.Continuation) -> Void) {
    self.stream = Stream(elementType: Element.self, bufferingPolicy: limit, build)
  }
  
  public func makeAsyncIterator() -> AsyncStream<Element>.Iterator {
    defer {
      self._runIfNeeded()
    }
    let id = UUID()
    let stream = Stream(elementType: Element.self) { _ in }
    stream.onTermination = { @Sendable [weak consumers] _ in
      let stop = consumers?.write { consumers in
        _ = consumers.removeValue(forKey: id)
        return consumers.isEmpty
      } ?? true
      guard stop else { return }
      self._stop()
    }
    self.consumers.write { consumers in
      consumers[id] = stream.continuation
    }
    return stream.asyncStream.makeAsyncIterator()
  }
  
  // MARK: - Publishing
  
  @discardableResult
  public func yield(_ value: Element) -> AsyncStream<Element>.Continuation.YieldResult {
    return self.stream.continuation.yield(value)
  }

  public func finish() {
    self.stream.continuation.finish()
  }
  
  // MARK: - Private
  
  private func _runIfNeeded() {
    self.consumersTask.write { task in
      guard task == nil else { return }
      
      task = Task { @Sendable in
        do {
          try Task.checkCancellation()
          
          for await value in stream.asyncStream {
            try Task.checkCancellation()
            let consumers = self.consumers.value.values
            guard !consumers.isEmpty else { continue }
            for consumer in consumers {
              consumer.yield(value)
            }
          }
          
          let consumers = self.consumers.value.values
          guard !consumers.isEmpty else { return }
          for consumer in consumers {
            consumer.finish()
          }
        } catch {
          let consumers = self.consumers.value.values
          for consumer in consumers {
            consumer.finish()
          }
          return
        }
      }
    }
  }
  
  private func _stop() {
    self.consumersTask.write { task in
      task?.cancel()
      task = nil
    }
  }
}

extension BroadcastAsyncStream {
  fileprivate struct Stream<StreamElement: Sendable>: Sendable {
    let id: UUID
    fileprivate var asyncStream: AsyncStream<StreamElement>!
    fileprivate var continuation: AsyncStream<StreamElement>.Continuation!
    
    init(_ id: UUID = UUID(), elementType: StreamElement.Type = StreamElement.self, bufferingPolicy limit: AsyncStream<StreamElement>.Continuation.BufferingPolicy = .unbounded, _ build: (AsyncStream<StreamElement>.Continuation) -> Void) {
      self.id = id
      
      let (stream, continuation) = AsyncStream.makeStream(of: elementType, bufferingPolicy: limit)
      self.asyncStream = stream
      self.continuation = continuation
      build(continuation)
    }

    public var onTermination: (@Sendable (AsyncStream<StreamElement>.Continuation.Termination) -> Void)? {
      get {
        return continuation.onTermination
      }
      nonmutating set {
        continuation.onTermination = newValue
      }
    }
  }
}

// MARK: - BroadcastAsyncStream + MapValues

extension BroadcastAsyncStream {
  public func mapValues<U: Sendable>(transform: @Sendable @escaping (Element) async throws -> U) -> BroadcastAsyncStream<Result<U, any Error>> {
    return BroadcastAsyncStream<Result<U, any Error>> { continuation in
      Task {
        for await value in self {
          
          let mapped: Result<U, any Error>
          do {
            mapped = .success(try await transform(value))
          } catch {
            mapped = .failure(error)
          }
          let result = continuation.yield(mapped)
          if case .terminated = result { return }
        }
        continuation.finish()
      }
    }
  }
}

// MARK: - BroadcastAsyncStream + Equatable

extension BroadcastAsyncStream: Equatable {
  public static func == (lhs: BroadcastAsyncStream<Element>, rhs: BroadcastAsyncStream<Element>) -> Bool {
    return lhs.id == rhs.id
  }
}

// MARK: - BroadcastAsyncStream + Hashable

extension BroadcastAsyncStream: Hashable {
  public func hash(into hasher: inout Hasher) {
    hasher.combine(id)
    hasher.combine([UUID](consumers.value.keys))
  }
}
