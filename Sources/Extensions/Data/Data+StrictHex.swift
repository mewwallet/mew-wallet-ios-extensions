//
//  File.swift
//  
//
//  Created by Mikhail Nikanorov on 6/25/21.
//

import Foundation

extension Data: StrictHexProtocol {
  public init?(strictHex hex: String) {
    guard hex.hasPrefix("0x") else { return nil }
    let bytes = Array<UInt8>(hex: hex)
    guard !bytes.isEmpty else {
      self = Data()
      return
    }
    
    self.init(bytes)
  }
}
