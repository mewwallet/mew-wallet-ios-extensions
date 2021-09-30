//
//  File.swift
//  
//
//  Created by Mikhail Nikanorov on 9/29/21.
//

import Foundation

extension Decimal {
  public var decimalString: String? {
    let formatter = NumberFormatter()
    formatter.numberStyle = .decimal
    formatter.maximumFractionDigits = 32
    formatter.maximumIntegerDigits = 32
    formatter.locale = Locale(identifier: "en_US_POSIX")
    return formatter.string(for: self)
  }
}
