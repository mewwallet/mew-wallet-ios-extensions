//
//  File.swift
//  
//
//  Created by Mikhail Nikanorov on 6/25/21.
//

import Foundation

extension Decimal: StrictHexProtocol {
  public init?(strictHex hex: String) {
    var value = Decimal()
    let hexValue = hex.stringRemoveHexPrefix()
    guard hexValue.count != 0 else {
      return nil
    }
    var position = hexValue.startIndex
    while position != hexValue.endIndex {
      let endRange = hexValue.index(position, offsetBy: 1)

      let hexChar = hexValue[position ..< endRange]
      guard let uintValue = UInt8(hexChar, radix: 16) else {
        return nil
      }
      if position != hexValue.startIndex {
        value *= Decimal(16)
      }
      value += Decimal(uintValue)

      position = endRange
    }
    self = value
  }
}
