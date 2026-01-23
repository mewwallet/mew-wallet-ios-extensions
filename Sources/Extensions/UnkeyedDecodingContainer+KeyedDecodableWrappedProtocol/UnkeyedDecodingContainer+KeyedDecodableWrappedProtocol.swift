//
//  File.swift
//  mew-wallet-ios-extensions
//
//  Created by Mikhail Nikanorov on 1/6/26.
//

import Foundation

public extension UnkeyedDecodingContainer {
  mutating func decodeWrapped<T:KeyedDecodableWrappedProtocol>(_ unwrap: String.Type, decodeHex: Bool = false) throws -> T {
    let wrapped = try self.decode(unwrap)
    let value = T(wrapped: wrapped, hex: decodeHex)
    
    guard value != nil else {
      throw DecodingError.dataCorruptedError(in: self, debugDescription: "Value: \(wrapped)")
    }
    return value!
  }
  
  mutating func decodeWrappedIfPresent<T:KeyedDecodableWrappedProtocol>(_ unwrap: String.Type, decodeHex: Bool = false) throws -> T? {
    guard let wrapped = try self.decodeIfPresent(unwrap) else {
      return nil
    }
    return T(wrapped: wrapped, hex: decodeHex)
  }
}
