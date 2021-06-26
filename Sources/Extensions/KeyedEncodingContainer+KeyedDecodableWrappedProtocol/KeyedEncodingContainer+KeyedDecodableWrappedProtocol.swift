//
//  File.swift
//  
//
//  Created by Mikhail Nikanorov on 6/25/21.
//

import Foundation

public extension KeyedEncodingContainer {
  mutating func encode<T>(_ value: Decimal, wrappedType: T, forKey key: KeyedEncodingContainer<K>.Key) throws {
    switch wrappedType {
    case is String.Type:
      let formatter = NumberFormatter()
      formatter.numberStyle = .decimal
      formatter.locale = Locale(identifier: "en_US_POSIX")
      let string = formatter.string(from: value as NSNumber)!
      try self.encode(string, forKey: key)
    default:
      throw EncodingError.invalidValue(value, EncodingError.Context(codingPath: [key], debugDescription: "Encoding of wrapped type is not supported yet: \(T.self)"))
    }
  }
  
  mutating func encodeIfPresent<T>(_ value: Decimal?, wrappedType: T, forKey key: KeyedEncodingContainer<K>.Key) throws {
    guard let value = value else {
      return
    }
    switch wrappedType {
    case is String.Type:
      let formatter = NumberFormatter()
      formatter.numberStyle = .decimal
      formatter.locale = Locale(identifier: "en_US_POSIX")
      guard let string = formatter.string(from: value as NSNumber) else {
        throw EncodingError.invalidValue(value, EncodingError.Context(codingPath: [key], debugDescription: "Can't convert value"))
      }
      try self.encodeIfPresent(string, forKey: key)
    default:
      throw EncodingError.invalidValue(self, EncodingError.Context(codingPath: [key], debugDescription: "Encoding of wrapped type is not supported yet: \(T.self)"))
    }
  }
}
