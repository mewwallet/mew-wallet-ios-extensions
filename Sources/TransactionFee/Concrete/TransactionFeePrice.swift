//
//  File.swift
//  
//
//  Created by Mikhail Nikanorov on 11/23/21.
//

import Foundation

public struct TransactionFeePrice: Hashable, Sendable {
  public let speed: TransactionFeeSpeed
  public let baseFee: Decimal
  public let tip: Decimal
  public var totalFee: Decimal {
    return baseFee + tip
  }
  
  /// Zero (empty) transaction fee speed
  public static var zero: TransactionFeePrice {
    return TransactionFeePrice(baseFee: .zero, tip: .zero, speed: .zero)
  }
  
  /// Create fee price based on values and speed
  /// - Parameters:
  ///   - baseFee: baseFeePerGas
  ///   - tip: maxPriorityFeePerGas
  ///   - speed: TransactionFeeSpeed
  public init(baseFee: Decimal, tip: Decimal, speed: TransactionFeeSpeed) {
    let gasPrice = baseFee + tip
    self.speed = speed
    self.baseFee = (baseFee * speed.baseFeeMultiplier(for: gasPrice)).rounded(0, .up)
    self.tip = (tip * speed.tipMultiplier(for: gasPrice)).rounded(0, .up)
  }
  
  /// Creates fee price with exact values
  /// - Parameters:
  ///   - exactBaseFee: baseFeePerGas
  ///   - exactTip: maxPriorityFeePerGas
  ///   - speed: TransactionFeeSpeed
  init(exactBaseFee: Decimal, exactTip: Decimal, speed: TransactionFeeSpeed) {
    self.speed = speed
    self.baseFee = exactBaseFee
    self.tip = exactTip
  }
  
  /// Calculates transaction fee
  /// - Parameters:
  ///   - limit: gasLimit of transaction(s)
  ///   - decimals: nil or token decimals, must be (10^-`decimals`) representation
  /// - Returns: Raw amount: in WEI, if `decimals` is `nil` and amount in ETH if decimals
  public func amount(for limit: Decimal, decimals: Decimal?) -> Decimal {
    return self.totalFee * limit * (decimals ?? Decimal(1))
  }
  
  /// Validates the provided balance can pay current fee
  /// - Parameters:
  ///   - limit: gasLimit of transaction(s)
  ///   - balance: raw account balance
  /// - Returns: true, if balance can conver transaction fee
  public func canBeUsed(for limit: Decimal, balance: Decimal) -> Bool {
    return self.amount(for: limit, decimals: nil) <= balance
  }
}
