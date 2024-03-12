//
//  File.swift
//  
//
//  Created by Mikhail Nikanorov on 2/26/24.
//

import Foundation

public final class ThreadSafe<T>: @unchecked Sendable {
  /// The unchecked value.
  private var _value: T
  public var value: T {
    _read {
      self._lock.lock(); defer { self._lock.unlock() }
      yield self._value
    }
    _modify {
      self._lock.lock(); defer { self._lock.unlock() }
      yield &self._value
    }
  }
  
  // MARK: Private
  
  private let _lock = UnfairLock()
  
  /// Initializes unchecked sendability around a value.
  ///
  /// - Parameter value: A value to make sendable in an unchecked way.
  public init(_ value: T) {
    self._value = value
  }
  
  public init(wrappedValue: T) {
    self._value = wrappedValue
  }
  
  public func read<V>(_ f: (T) -> V) -> V {
    self._lock.lock(); defer { self._lock.unlock() }
    return f(self._value)
  }
  
  @discardableResult
  public func write<V>(_ f: (inout T) -> V) -> V {
    self._lock.lock(); defer { self._lock.unlock() }
    return f(&self._value)
  }
}
