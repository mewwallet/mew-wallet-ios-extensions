//
//  File.swift
//  
//
//  Created by Mikhail Nikanorov on 5/3/23.
//

import Foundation

public typealias EVMBundledTransactionFee = BundledTransactionFee<EVMTransactionFee>

/// Stores `TransactionFee` and related `crypto` and `fiat` amount
public struct BundledTransactionFee<T: TransactionFee>: Sendable, Hashable {
  public var fee: T
  public let amount: BundledDecimal
  
  public static func zero(symbol: String, currency: FiatCurrency?) -> BundledTransactionFee<T> {
    return BundledTransactionFee<T>(fee: .zero, amount: .zero(symbol: symbol, currency: currency))
  }
  
  public init(fee: T, amount: BundledDecimal) {
    self.fee = fee
    self.amount = amount
  }
}

// MARK: - BundledTransactionFee + Equatable

extension BundledTransactionFee: Equatable {}
