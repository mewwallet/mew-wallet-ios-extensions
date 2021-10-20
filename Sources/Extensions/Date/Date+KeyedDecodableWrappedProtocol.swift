//
//  File.swift
//  
//
//  Created by Mikhail Nikanorov on 10/19/21.
//

import Foundation

extension Date: KeyedDecodableWrappedProtocol {
  public init?(wrapped: String, hex: Bool) {
    if hex {
      self.init(strictHex: wrapped)
    } else {
      guard let interval = TimeInterval(wrapped) else { return nil }
      self = Date(timeIntervalSince1970: interval)
    }
  }
}
