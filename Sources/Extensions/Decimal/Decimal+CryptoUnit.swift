//
//  File.swift
//  
//
//  Created by Mikhail Nikanorov on 2/9/22.
//

import Foundation

public extension Decimal {
  func convert(from: CryptoUnit = .wei, to: CryptoUnit) -> Decimal {
    return CryptoUnit.convert(amount: self, from: from, to: to)
  }
}
