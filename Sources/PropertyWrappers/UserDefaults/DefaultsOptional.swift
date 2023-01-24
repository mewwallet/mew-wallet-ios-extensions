//
//  File.swift
//  
//
//  Created by Mikhail Nikanorov on 1/15/23.
//

import Combine
import Foundation

/// A property wrapper that uses `UserDefaults` as a backing store,
/// whose `wrappedValue` is optional and **does not provide default value**.
@propertyWrapper
public struct DefaultsOptional<T: DefaultsSerializable> {
  private let _userDefaults: UserDefaults
  private let _publisher: CurrentValueSubject<T?, Never>
  
  /// The key for the value in `UserDefaults`.
  public let key: any DefaultsKey
  
  /// The value retreived from `UserDefaults`, if any exists.
  public var wrappedValue: T? {
    get {
      _userDefaults.fetchOptional(self.key)
    }
    set {
      if let newValue {
        _userDefaults.save(newValue, for: self.key)
        _publisher.send(newValue)
      } else {
        _userDefaults.delete(for: self.key)
        _publisher.send(nil)
      }
    }
  }
  
  /// A publisher that delivers updates to subscribers.
  public var projectedValue: AnyPublisher<T?, Never> {
    _publisher.eraseToAnyPublisher()
  }
  
  /// Initializes the property wrapper.
  /// - Parameters:
  ///   - keyName: The key for the value in `UserDefaults`.
  ///   - userDefaults: The `UserDefaults` backing store. The default value is `.standard`.
  public init(key keyName: any DefaultsKey, userDefaults: UserDefaults = .standard) {
    key = keyName
    _userDefaults = userDefaults
    _publisher = CurrentValueSubject<T?, Never>(userDefaults.fetchOptional(keyName))
  }
}
