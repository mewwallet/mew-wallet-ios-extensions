//
//  File.swift
//  
//
//  Created by Mikhail Nikanorov on 6/25/21.
//

import Foundation

extension Data {
  public mutating func setLength(_ length: Int, appendFromLeft: Bool = true, negative: Bool = false) {
    guard self.count < length else {
      return
    }
    
    let leftLength = length - self.count
    
    if appendFromLeft {
      self = Data(repeating: negative ? 0xFF : 0x00, count: leftLength) + self
    } else {
      self += Data(repeating: negative ? 0xFF : 0x00, count: leftLength)
    }
  }
  
  public func setLengthLeft(_ toBytes: Int, isNegative: Bool = false) -> Data {
    var data = self
    data.setLength(toBytes, negative: isNegative)
    return data
  }
  
  public func setLengthRight(_ toBytes: Int, isNegative: Bool = false) -> Data {
    var data = self
    data.setLength(toBytes, appendFromLeft: false, negative: isNegative)
    
    return data
  }
}
