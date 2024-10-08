//
//  File.swift
//  
//
//  Created by Mikhail Nikanorov on 12/21/22.
//

import Foundation
import Combine

extension Publisher {
  public func mapAsync<T: Sendable>(_ transform: @escaping @Sendable (Output) async -> T) -> Publishers.FlatMap<Future<T, Never>, Self> {
    flatMap { value in
      let value = UnknownSendable(value: value)
      
      return Future<T, Never> { promise in
        let promise = UnknownSendable(value: promise)
        
        Task {
          let result = await transform(value.value)
          promise.value(.success(result))
        }
      }
    }
  }
}
