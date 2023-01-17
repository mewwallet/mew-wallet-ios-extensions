//
//  File.swift
//  
//
//  Created by Mikhail Nikanorov on 1/15/23.
//

import Combine
import Foundation

/// A property wrapper that uses `UserDefaults` as a backing store,
/// whose `wrappedValue` is non-optional and registers a **non-optional default value**.
@propertyWrapper
public struct Defaults<T: DefaultsSerializable> {
  private let _userDefaults: UserDefaults
  private let _publisher: CurrentValueSubject<T, Never>
  
  /// The key for the value in `UserDefaults`.
  public let key: any DefaultsKey
  
  /// The value retrieved from `UserDefaults`.
  public var wrappedValue: T {
    get {
      _userDefaults.fetch(self.key)
    }
    set {
      _userDefaults.save(newValue, for: self.key)
      _publisher.send(newValue)
    }
  }
  
  /// A publisher that delivers updates to subscribers.
  public var projectedValue: AnyPublisher<T, Never> {
    _publisher.eraseToAnyPublisher()
  }
  
  /// Initializes the property wrapper.
  /// - Parameters:
  ///   - wrappedValue: The default value to register for the specified key.
  ///   - keyName: The key for the value in `UserDefaults`.
  ///   - userDefaults: The `UserDefaults` backing store. The default value is `.standard`.
  public init(wrappedValue: T, key keyName: any DefaultsKey, userDefaults: UserDefaults = .standard) {
    key = keyName
    _userDefaults = userDefaults
    _userDefaults.registerDefault(value: wrappedValue, key: keyName)
    
    // Publisher must be initialized after `registerDefault`,
    // because `fetch` assumes that `registerDefault` has been called before
    // and uses force unwrap
    _publisher = CurrentValueSubject<T, Never>(userDefaults.fetch(keyName))
  }
}
