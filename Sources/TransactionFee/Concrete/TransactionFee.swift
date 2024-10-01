//
//  File.swift
//  
//
//  Created by Mikhail Nikanorov on 1/20/22.
//

import Foundation

public struct TransactionFee: Hashable, Sendable {
  public var limit: Decimal
  public var price: TransactionFeePrice
  
  /// Zero (empty) transaction fee
  public static var zero: TransactionFee {
    return TransactionFee(limit: .zero, price: .zero)
  }
  
  public init(limit: Decimal, price: TransactionFeePrice) {
    self.limit = limit
    self.price = price
  }
  
  public mutating func update(limit: Decimal) {
    self.limit = limit
  }
  
  public mutating func update(price: TransactionFeePrice) {
    self.price = price
  }
  
  public func amount(decimals: Decimal?) -> Decimal {
    precondition(!(decimals ?? Decimal(1)).isZero)
    return self.price.amount(for: self.limit, decimals: decimals)
  }
  
  public func amount(decimals: Int = 1) -> Decimal {
    precondition(decimals != 0)
    let decimals = Decimal(sign: .plus, exponent: -decimals, significand: Decimal(1))
    return self.amount(decimals: decimals)
  }
  
  /// Validates the provided balance can pay fee
  /// - Parameters:
  ///   - balance: raw account balance
  /// - Returns: true, if balance can conver transaction fee
  public func canBeUsed(for balance: Decimal) -> Bool {
    return self.price.canBeUsed(for: self.limit, balance: balance)
  }
}
