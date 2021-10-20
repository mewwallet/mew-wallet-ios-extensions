//
//  File.swift
//  
//
//  Created by Mikhail Nikanorov on 6/25/21.
//

import Foundation

public extension KeyedEncodingContainer {
  mutating func encode<V: HexProtocol, T>(_ value: V, forKey key: KeyedEncodingContainer<K>.Key, wrapIn: T, encodeHex: Bool = false) throws {
    switch (type(of: value), wrapIn) {
    case (_, is String.Type) where encodeHex:
      try self.encode(value.hexString, forKey: key)
    case (is Data.Type, is String.Type) where !encodeHex:
      try self.encode(value as! Data, forKey: key)
    case (is Decimal.Type, is String.Type) where !encodeHex:
      try self.encode((value as! Decimal).decimalString, forKey: key)
    case (is URL.Type, is String.Type) where !encodeHex:
      let url = value as! URL
      try self.encode(url.absoluteString, forKey: key)
    case (is Date.Type, is String.Type) where !encodeHex:
      try self.encode((value as! Date).decimalString, forKey: key)
    default:
      throw EncodingError.invalidValue(value, EncodingError.Context(codingPath: [key], debugDescription: "Encoding of wrapped type is not supported yet: \(T.self)"))
    }
  }
  
  mutating func encodeIfPresent<V: HexProtocol, T>(_ value: V?, forKey key: KeyedEncodingContainer<K>.Key, wrapIn: T, encodeHex: Bool = false) throws {
    guard let value = value else {
      return
    }
    switch (type(of: value), wrapIn) {
    case (_, is String.Type) where encodeHex:
      try self.encodeIfPresent(value.hexString, forKey: key)
    case (is Data.Type, is String.Type) where encodeHex:
      try self.encodeIfPresent(value as? Data, forKey: key)
    case (is Decimal.Type, is String.Type) where !encodeHex:
      try self.encodeIfPresent((value as! Decimal).decimalString, forKey: key)
    case (is URL.Type, is String.Type):
      let url = value as! URL
      try self.encodeIfPresent(url.absoluteString, forKey: key)
    case (is Date.Type, is String.Type) where !encodeHex:
      try self.encodeIfPresent((value as! Date).decimalString, forKey: key)
    default:
      throw EncodingError.invalidValue(self, EncodingError.Context(codingPath: [key], debugDescription: "Encoding of wrapped type is not supported yet: \(T.self)"))
    }
  }
}
