//
//  File.swift
//  
//
//  Created by Mikhail Nikanorov on 6/25/21.
//

import Foundation

extension Data: KeyedDecodableWrappedProtocol {
  public init?(wrapped: String, hex: Bool) {
    if hex {
      guard let data = Data(strictHex: wrapped) else { return nil }
      self = data
    } else {
      guard let data = wrapped.data(using: .utf8) else { return nil }
      self = data
    }
  }
}
