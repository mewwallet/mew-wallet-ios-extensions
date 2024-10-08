//
//  File.swift
//  
//
//  Created by Mikhail Nikanorov on 12/21/22.
//

import Foundation
import Combine

extension Publisher {
  public func mapAsyncThrows<T>(_ transform: @escaping @Sendable (Output) async throws -> T) -> Publishers.FlatMap<Future<T, any Error>, Publishers.SetFailureType<Self, any Error>> {
    flatMap { value in
      let value = UnknownSendable(value: value)
      
      return Future { promise in
        let promise = UnknownSendable(value: promise)
        
        Task {
          do {
            let output = try await transform(value.value)
            promise.value(.success(output))
          } catch {
            promise.value(.failure(error))
          }
        }
      }
    }
  }
}
