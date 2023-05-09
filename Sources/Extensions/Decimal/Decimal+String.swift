//
//  File.swift
//  
//
//  Created by Mikhail Nikanorov on 9/29/21.
//

import Foundation

extension Decimal {
  public var decimalString: String {
    return self.decimalString()
  }
  
  public func decimalString(locale: Locale = Locale(identifier: "en_US_POSIX")) -> String {
    let formatter = NumberFormatter()
    formatter.numberStyle = .decimal
    formatter.maximumFractionDigits = 8
    formatter.maximumIntegerDigits = 8
    formatter.locale = locale
    
    let integer = abs(self).integerDivisionBy(Decimal(1))
    
    let reminder = abs(self).truncatingRemainder(dividingBy: Decimal(1))
    let integerReminder = reminder * Decimal(sign: .plus, exponent: abs(reminder.exponent), significand: Decimal(1))
    
    let integerString = integer.representationOf(base: Decimal(10))
    var reminderString = integerReminder.representationOf(base: Decimal(10))
    if reminderString.count != abs(reminder.exponent), !reminder.isZero {
      let zeroString = Decimal.zero.representationOf(base: Decimal(10))
      let count = abs(reminder.exponent) - reminderString.count
      let reminderPrefix = String(repeating: zeroString, count: count)
      reminderString.insert(contentsOf: reminderPrefix, at: reminderString.startIndex)
    }
    
    let prefix: String!
    var format: String!
    let suffix: String!
    
    if self >= .zero {
      prefix = formatter.positivePrefix
      format = formatter.positiveFormat
      suffix = formatter.positiveSuffix
    } else {
      prefix = formatter.negativePrefix
      format = formatter.negativeFormat
      suffix = formatter.negativeSuffix
    }
    
    guard
      let firstPosition = format.firstIndex(of: "#"),
      let lastPosition = format.lastIndex(of: "#"),
      let decimalPosition = format.range(of: formatter.decimalSeparator) else {
        return prefix + integerString + formatter.decimalSeparator + reminderString + suffix
      }
    
    if !reminder.isZero {
      format.replaceSubrange(decimalPosition.upperBound...lastPosition, with: reminderString)
    } else {
      format.replaceSubrange(decimalPosition.lowerBound...lastPosition, with: "")
    }
    
    format.replaceSubrange(firstPosition..<decimalPosition.lowerBound, with: integerString)
    
    format.insert(contentsOf: prefix, at: format.startIndex)
    format.append(contentsOf: suffix)
    
    return format
  }
}
