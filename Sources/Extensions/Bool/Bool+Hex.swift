//
//  File.swift
//  
//
//  Created by Mikhail Nikanorov on 6/25/21.
//

import Foundation

extension Bool: HexProtocol {
  public var hexString: String {
    return self ? "0x01" : "0x00"
  }
  
  public init(hex: String) {
    self = (hex.stringRemoveHexPrefix() != "00")
  }
}
