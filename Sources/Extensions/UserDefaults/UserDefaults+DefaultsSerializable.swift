//
//  File.swift
//  
//
//  Created by Mikhail Nikanorov on 1/15/23.
//

import Foundation

// swiftlint:disable force_cast
extension UserDefaults {
  
  func save<T: DefaultsSerializable>(_ value: T, for key: any DefaultsKey) {
    switch T.self {
    case is URL.Type:
      // Hack for URL, which is special
      // See: http://dscoder.com/defaults.html
      // Error: Attempt to insert non-property list object, NSInvalidArgumentException
      self.set(value as? URL, forKey: key.rawValue)
    case is Locale.Type:
      self.set((value as? Locale)?.identifier, forKey: key.rawValue)
    default:
      self.set(value.storedValue, forKey: key.rawValue)
    }
  }
  
  public func delete(for key: any DefaultsKey) {
    self.removeObject(forKey: key.rawValue)
  }
  
  func fetch<T: DefaultsSerializable>(_ key: any DefaultsKey) -> T {
    self.fetchOptional(key)!
  }
  
  func fetchOptional<T: DefaultsSerializable>(_ key: any DefaultsKey) -> T? {
    let fetched: Any?
    
    switch T.self {
    case is URL.Type:
      // Hack for URL, which is special
      // See: http://dscoder.com/defaults.html
      // Error: Could not cast value of type '_NSInlineData' to 'NSURL'
      fetched = self.url(forKey: key.rawValue)
    case is Locale.Type:
      guard let identifier = self.string(forKey: key.rawValue) else { return nil }
      fetched = Locale(identifier: identifier)
    default:
      fetched = self.object(forKey: key.rawValue)
    }
    
    guard let fetched else { return nil }
    
    return try? T(storedValue: fetched as! T.StoredValue)
  }
  
  func registerDefault<T: DefaultsSerializable>(value: T, key: any DefaultsKey) {
    self.register(defaults: [key.rawValue: value.storedValue])
  }
}

// swiftlint:enable force_cast
