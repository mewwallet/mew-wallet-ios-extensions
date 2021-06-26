//
//  File.swift
//  
//
//  Created by Mikhail Nikanorov on 6/25/21.
//

import Foundation

extension Data: StrictHexProtocol {
  public init?(strictHex hex: String) {
    let bytes = Array<UInt8>(hex: hex)
    guard !bytes.isEmpty else { return nil }
    
    self.init(bytes)
  }
}
