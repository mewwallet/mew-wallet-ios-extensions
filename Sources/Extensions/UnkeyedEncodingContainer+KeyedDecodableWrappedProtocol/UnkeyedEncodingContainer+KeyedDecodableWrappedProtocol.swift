//
//  File.swift
//  mew-wallet-ios-extensions
//
//  Created by Mikhail Nikanorov on 1/6/26.
//

import Foundation

public extension UnkeyedEncodingContainer {
  mutating func encode<V: HexProtocol, T>(_ value: V, wrapIn: T, encodeHex: Bool = false) throws {
    switch (type(of: value), wrapIn) {
    case (_, is String.Type) where encodeHex:
      try self.encode(value.hexString)
    case (is Data.Type, is String.Type) where !encodeHex:
      try self.encode(value as! Data)
    case (is Decimal.Type, is String.Type) where !encodeHex:
      try self.encode((value as! Decimal).decimalString)
    case (is URL.Type, is String.Type) where !encodeHex:
      let url = value as! URL
      try self.encode(url.absoluteString)
    case (is Date.Type, is String.Type) where !encodeHex:
      try self.encode((value as! Date).decimalString)
    default:
      throw EncodingError.invalidValue(value, EncodingError.Context(codingPath: self.codingPath, debugDescription: "Encoding of wrapped type is not supported yet: \(T.self)"))
    }
  }
}
