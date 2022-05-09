//
//  File.swift
//  
//
//  Created by Mikhail Nikanorov on 4/20/22.
//

import Foundation

public enum ValueWrapper: Codable, Hashable {
  case stringValue(String)
  case intValue(Int64)
  
  public init(from decoder: Decoder) throws {
    let container = try decoder.singleValueContainer()
    if let value = try? container.decode(String.self) {
      self = .stringValue(value)
      return
    }
    if let value = try? container.decode(Int64.self) {
      self = .intValue(value)
      return
    }
    
    throw DecodingError.typeMismatch(ValueWrapper.self, DecodingError.Context(codingPath: decoder.codingPath, debugDescription: "Wrong type for ValueWrapper"))
  }
  
  public func encode(to encoder: Encoder) throws {
    var container = encoder.singleValueContainer()
    switch self {
    case let .stringValue(value):
      try container.encode(value)
    case let .intValue(value):
      try container.encode(value)
    }
  }
  
  public var stringValue: String? {
    guard case .stringValue(let value) = self else {
      return nil
    }
    return value
  }
  
  public var intValue: Int64? {
    guard case .intValue(let value) = self else {
      return nil
    }
    return value
  }
}
