//
//  String+Hex.swift
//  
//
//  Created by Mikhail Nikanorov on 6/25/21.
//

import Foundation

private let _nonHexCharacterSet = CharacterSet(charactersIn: "0123456789ABCDEF").inverted

extension String {
  public func isHex() -> Bool {
    var rawHex = self
    rawHex.removeHexPrefix()
    rawHex = rawHex.uppercased()
    return (rawHex.rangeOfCharacter(from: _nonHexCharacterSet) == nil)
  }

  public mutating func removeHexPrefix() {
    guard self.hasPrefix("0x") else { return }
    
    let indexStart = self.index(self.startIndex, offsetBy: 2)
    self = String(self[indexStart...])
  }

  public mutating func addHexPrefix() {
    guard !self.hasPrefix("0x") else { return }
    
    self = "0x" + self
  }

  public func stringRemoveHexPrefix() -> String {
    var string = self
    string.removeHexPrefix()
    return string
  }

  public func stringAddHexPrefix() -> String {
    var string = self
    string.addHexPrefix()
    return string
  }
}
