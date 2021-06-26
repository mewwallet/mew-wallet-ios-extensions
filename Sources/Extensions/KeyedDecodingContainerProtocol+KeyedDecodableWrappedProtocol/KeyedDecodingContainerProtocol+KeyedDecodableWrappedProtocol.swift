//
//  File.swift
//  
//
//  Created by Mikhail Nikanorov on 6/25/21.
//

import Foundation

public extension KeyedDecodingContainerProtocol {
  func decode<T:KeyedDecodableWrappedProtocol>(wrappedType: String.Type, forKey key: Self.Key) throws -> T {
    let wrapped = try self.decode(wrappedType, forKey: key)
    guard let decimal = T(wrapped: wrapped) else {
      throw DecodingError.dataCorruptedError(forKey: key, in: self, debugDescription: "Value: \(wrapped)")
    }
    return decimal
  }
  
  func decodeIfPresent<T:KeyedDecodableWrappedProtocol>(wrappedType: String.Type, forKey key: Self.Key) throws -> T? {
    guard let wrapped = try self.decodeIfPresent(wrappedType, forKey: key) else {
      return nil
    }
    guard let decimal = T(wrapped: wrapped) else {
      throw DecodingError.dataCorruptedError(forKey: key, in: self, debugDescription: "Value: \(wrapped)")
    }
    return decimal
  }
}
