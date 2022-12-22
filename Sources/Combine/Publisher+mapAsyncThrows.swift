//
//  File.swift
//  
//
//  Created by Mikhail Nikanorov on 12/21/22.
//

import Foundation
import Combine

extension Publisher {
  public func mapAsyncThrows<T>(_ transform: @escaping (Output) async throws -> T) -> Publishers.FlatMap<Future<T, Error>, Publishers.SetFailureType<Self, Error>> {
    flatMap { value in
      Future { promise in
        Task {
          do {
            let output = try await transform(value)
            promise(.success(output))
          } catch {
            promise(.failure(error))
          }
        }
      }
    }
  }
}
