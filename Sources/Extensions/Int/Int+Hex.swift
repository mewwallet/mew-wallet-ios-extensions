//
//  File.swift
//  
//
//  Created by Mikhail Nikanorov on 6/25/21.
//

import Foundation

extension Int: HexProtocol {
  public var hexString: String {
    return String(format:"%02X", self)
  }
  
  public init(hex: String) {
    if let value = Int(hex, radix: 16) {
      self = value
    } else {
      self = 0
    }
  }
}
