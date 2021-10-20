//
//  File.swift
//  
//
//  Created by Mikhail Nikanorov on 10/19/21.
//

import Foundation

extension Date: HexProtocol {
  
  public var hexString: String {
    let value = UInt(self.timeIntervalSince1970.rounded(.down))
    return String(value, radix: 16, uppercase: false).stringAddHexPrefix()
  }
  
  public init(hex: String) {
    var value: TimeInterval = 0
    let hexValue = hex.stringRemoveHexPrefix()
    guard hexValue.count != 0 else {
      self = Date(timeIntervalSince1970: 0)
      return
    }
    var position = hexValue.startIndex
    while position != hexValue.endIndex {
      let endRange = hexValue.index(position, offsetBy: 1)

      let hexChar = hexValue[position ..< endRange]
      guard let uintValue = UInt8(hexChar, radix: 16) else {
        self = Date(timeIntervalSince1970: 0)
        return
      }
      if position != hexValue.startIndex {
        value *= 16
      }
      value += TimeInterval(uintValue)

      position = endRange
    }
    self = Date(timeIntervalSince1970: value)
  }
}
