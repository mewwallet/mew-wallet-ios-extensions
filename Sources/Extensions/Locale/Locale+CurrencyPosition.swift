//
//  File.swift
//  mew-wallet-ios-extensions
//
//  Created by Mikhail Nikanorov on 10/1/24.
//

import Foundation

extension Locale {
  public func amountPrefix(currency: FiatCurrency) -> String? {
    let formatter = NumberFormatter()
    formatter.numberStyle = .currency
    formatter.locale = self
    formatter.currencyCode = currency.rawValue
    formatter.maximumFractionDigits = 0
    formatter.usesGroupingSeparator = false
    formatter.currencyDecimalSeparator = ""
    formatter.decimalSeparator = ""
    guard let string = formatter.string(for: 0) else { return nil }
    guard let zeroRange = string.range(of: "0"),
          let currencyRange = string.range(of: formatter.currencySymbol) else { return nil }
    guard currencyRange.lowerBound < zeroRange.lowerBound else { return nil }
    return string.components(separatedBy: .decimalDigits).joined()
  }
  
  public func amountSuffix(currency: FiatCurrency) -> String? {
    let formatter = NumberFormatter()
    formatter.numberStyle = .currency
    formatter.locale = self
    formatter.currencyCode = currency.rawValue
    formatter.maximumFractionDigits = 0
    formatter.usesGroupingSeparator = false
    formatter.currencyDecimalSeparator = ""
    formatter.decimalSeparator = ""
    guard let string = formatter.string(for: 0) else { return nil }
    guard let zeroRange = string.range(of: "0"),
          let currencyRange = string.range(of: formatter.currencySymbol) else { return nil }
    guard currencyRange.lowerBound >= zeroRange.lowerBound else { return nil }
    return string.components(separatedBy: .decimalDigits).joined()
  }
}
