//
//  File.swift
//  
//
//  Created by Mikhail Nikanorov on 5/3/23.
//

import Foundation

/// Stores `TransactionFee` and related `crypto` and `fiat` amount
public struct BundledTransactionFee: Sendable, Hashable {
  public var fee: TransactionFee
  public let amount: BundledDecimal
  
  public static func zero(symbol: String, currency: FiatCurrency?) -> BundledTransactionFee {
    return BundledTransactionFee(fee: .zero, amount: .zero(symbol: symbol, currency: currency))
  }
  
  public init(fee: TransactionFee, amount: BundledDecimal) {
    self.fee = fee
    self.amount = amount
  }
}

// MARK: - BundledTransactionFee + Equatable

extension BundledTransactionFee: Equatable {}
