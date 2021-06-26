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
      let formatter = NumberFormatter()
      formatter.numberStyle = .decimal
      formatter.locale = Locale(identifier: "en_US_POSIX")
      let string = formatter.string(from: value as! NSNumber)!
      try self.encode(string, forKey: key)
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
      let formatter = NumberFormatter()
      formatter.numberStyle = .decimal
      formatter.locale = Locale(identifier: "en_US_POSIX")
      guard let string = formatter.string(from: value as! NSNumber) else {
        throw EncodingError.invalidValue(value, EncodingError.Context(codingPath: [key], debugDescription: "Can't convert value"))
      }
      try self.encodeIfPresent(string, forKey: key)
    default:
      throw EncodingError.invalidValue(self, EncodingError.Context(codingPath: [key], debugDescription: "Encoding of wrapped type is not supported yet: \(T.self)"))
    }
  }
}
