//
//  File.swift
//  
//
//  Created by Mikhail Nikanorov on 6/25/21.
//

import Foundation

public extension KeyedDecodingContainerProtocol {
  func decodeWrapped<T:KeyedDecodableWrappedProtocol>(_ unwrap: String.Type, forKey key: Self.Key, decodeHex: Bool = false) throws -> T {
    let wrapped = try self.decode(unwrap, forKey: key)
    let value = T(wrapped: wrapped, hex: decodeHex)
    
    guard value != nil else {
      throw DecodingError.dataCorruptedError(forKey: key, in: self, debugDescription: "Value: \(wrapped)")
    }
    return value!
  }
  
  func decodeWrappedIfPresent<T:KeyedDecodableWrappedProtocol>(_ unwrap: String.Type, forKey key: Self.Key, decodeHex: Bool = false) throws -> T? {
    guard let wrapped = try self.decodeIfPresent(unwrap, forKey: key) else {
      return nil
    }
    return T(wrapped: wrapped, hex: decodeHex)
  }
}
