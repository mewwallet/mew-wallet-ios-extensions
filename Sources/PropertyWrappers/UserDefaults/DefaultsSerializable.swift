//
//  File.swift
//  
//
//  Created by Mikhail Nikanorov on 1/15/23.
//

import Foundation

/// Describes a value that can be saved to and fetched from `UserDefaults`.
///
/// Default conformances are provided for:
///    - `Bool`
///    - `Int`
///    - `UInt`
///    - `Float`
///    - `Double`
///    - `String`
///    - `URL`
///    - `Date`
///    - `Data`
///    - `Array`
///    - `Set`
///    - `Dictionary`
///    - `RawRepresentable` types
public protocol DefaultsSerializable {
  
  /// The type of the value that is stored in `UserDefaults`.
  associatedtype StoredValue
  
  /// The value to store in `UserDefaults`.
  var storedValue: StoredValue { get }
  
  /// Initializes the object using the provided value.
  ///
  /// - Parameter storedValue: The previously store value fetched from `UserDefaults`.
  static func load(from storedValue: StoredValue) throws -> Self
}

/// :nodoc:
extension Bool: DefaultsSerializable {
  public var storedValue: Self { self }
  
  public static func load(from storedValue: Bool) throws -> Bool {
    return storedValue
  }
}

/// :nodoc:
extension Int: DefaultsSerializable {
  public var storedValue: Self { self }
  
  public static func load(from storedValue: Self) throws -> Int {
    return storedValue
  }
}

/// :nodoc:
extension UInt: DefaultsSerializable {
  public var storedValue: Self { self }
  
  public static func load(from storedValue: Self) throws -> UInt {
    return storedValue
  }
}

/// :nodoc:
extension Float: DefaultsSerializable {
  public var storedValue: Self { self }
  
  public static func load(from storedValue: Self) throws -> Float {
    return storedValue
  }
}

/// :nodoc:
extension Double: DefaultsSerializable {
  public var storedValue: Self { self }
  
  public static func load(from storedValue: Self) throws -> Double {
    return storedValue
  }
}

/// :nodoc:
extension String: DefaultsSerializable {
  public var storedValue: Self { self }
  
  public static func load(from storedValue: Self) throws -> String {
    return storedValue
  }
}

/// :nodoc:
extension URL: DefaultsSerializable {
  public var storedValue: Self { self }
  
  public static func load(from storedValue: Self) throws -> URL {
    return storedValue
  }
}

/// :nodoc:
extension Date: DefaultsSerializable {
  public var storedValue: Self { self }
  
  public static func load(from storedValue: Self) throws -> Date {
    storedValue
  }
}

/// :nodoc:
extension Data: DefaultsSerializable {
  public var storedValue: Self { self }
  
  public static func load(from storedValue: Self) throws -> Data {
    return storedValue
  }
}

/// :nodoc:
extension Array: DefaultsSerializable where Element: DefaultsSerializable {
  public var storedValue: [Element.StoredValue] {
    self.map { $0.storedValue }
  }
  
  public static func load(from storedValue: [Element.StoredValue]) throws -> Array<Element> {
    return try storedValue.map({ try Element.load(from: $0) })
  }
}

/// :nodoc:
//extension Set: DefaultsSerializable where Element: DefaultsSerializable {
//  public var storedValue: [Element.StoredValue] {
//    self.map { $0.storedValue }
//  }
//
//  public init(storedValue: [Element.StoredValue]) throws {
//    self = try Set(storedValue.map { try Element(storedValue: $0) })
//  }
//}

/// :nodoc:
//extension Dictionary: DefaultsSerializable where Key == String, Value: DefaultsSerializable {
//  public var storedValue: [String: Value.StoredValue] {
//    self.mapValues { $0.storedValue }
//  }
//
//  public init(storedValue: [String: Value.StoredValue]) throws {
//    self = try storedValue.mapValues { try Value(storedValue: $0) }
//  }
//}

/// :nodoc:
//extension DefaultsSerializable where Self: RawRepresentable, Self.RawValue: DefaultsSerializable {
//  public var storedValue: RawValue.StoredValue { self.rawValue.storedValue }
//
//  public init(storedValue: RawValue.StoredValue) throws {
//    self = Self(rawValue: try Self.RawValue(storedValue: storedValue))!
//  }
//}

/// :nodoc:
extension Locale: DefaultsSerializable {
  public var storedValue: Self { self }
  
  public static func load(from storedValue: Locale) throws -> Locale {
    return storedValue
  }
}
