//
//  File.swift
//  
//
//  Created by Mikhail Nikanorov on 12/21/22.
//

import Foundation
import Combine

extension Publisher {
  public func mapAsync<T>(_ transform: @escaping (Output) async -> T) -> Publishers.FlatMap<Future<T, Never>, Self> {
    flatMap { value in
      Future { promise in
        Task {
          promise(.success(await transform(value)))
        }
      }
    }
  }
}
