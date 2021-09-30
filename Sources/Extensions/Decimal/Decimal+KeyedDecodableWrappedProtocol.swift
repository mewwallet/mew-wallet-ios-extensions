//
//  File.swift
//  
//
//  Created by Mikhail Nikanorov on 6/25/21.
//

import Foundation

extension Decimal: KeyedDecodableWrappedProtocol {
  public init?(wrapped: String, hex: Bool) {
    if hex {
      self.init(strictHex: wrapped)
    } else {
      var wrapped = wrapped
      wrapped = wrapped.replacingOccurrences(of: ",", with: ".")
      guard let value = Decimal(string: wrapped, locale: Locale(identifier: "en_US_POSIX")) else {
        return nil
      }
      self = value
    }
  }
}
