//
//  File.swift
//  
//
//  Created by Mikhail Nikanorov on 6/25/21.
//

import Foundation

extension Decimal: HexProtocol {
  public var hexString: String {
    return self.representationOf(base: Decimal(16)).stringAddHexPrefix()
  }
  
  public init(hex: String) {
    var value = Decimal()
    let hexValue = hex.stringRemoveHexPrefix()
    guard hexValue.count != 0 else {
      self = .zero
      return
    }
    var position = hexValue.startIndex
    while position != hexValue.endIndex {
      let endRange = hexValue.index(position, offsetBy: 1)

      let hexChar = hexValue[position ..< endRange]
      guard let uintValue = UInt8(hexChar, radix: 16) else {
        self = .zero
        return
      }
      if position != hexValue.startIndex {
        value *= Decimal(16)
      }
      value += Decimal(uintValue)

      position = endRange
    }
    self = value
  }
  
  // MARK: - Private
  
  private func integerDivisionBy(_ operand: Decimal) -> Decimal {
    let result = (self / operand)
    return result.rounded(0, result < 0 ? .up : .down)
  }

  private func truncatingRemainder(dividingBy operand: Decimal) -> Decimal {
    return self - self.integerDivisionBy(operand) * operand
  }

  private func representationOf(base: Decimal) -> String {
    var buffer: [Int] = []
    var number = self

    while number > 0 {
      buffer.append((number.truncatingRemainder(dividingBy: base) as NSDecimalNumber).intValue)
      number = number.integerDivisionBy(base)
    }

    return buffer
      .reversed()
      .map { String($0, radix: (base as NSDecimalNumber).intValue ) }
      .joined()
  }
}
