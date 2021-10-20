//
//  File.swift
//  
//
//  Created by Mikhail Nikanorov on 10/19/21.
//

import Foundation

extension Date: StrictHexProtocol {
  public init?(strictHex hex: String) {
    var value: TimeInterval = 0
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
        value *= TimeInterval(16)
      }
      value += TimeInterval(uintValue)

      position = endRange
    }
    self = Date(timeIntervalSince1970: value)
  }
}
