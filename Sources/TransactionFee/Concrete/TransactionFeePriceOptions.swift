//
//  File.swift
//  
//
//  Created by Mikhail Nikanorov on 11/23/21.
//

import Foundation

public struct TransactionFeePriceOptions {
  public let opportunistic: TransactionFeePrice
  public let economy: TransactionFeePrice
  public let recommended: TransactionFeePrice
  public let higherPriority: TransactionFeePrice
  public let highestPriority: TransactionFeePrice
  
  /// Creates options with base values
  /// - Parameters:
  ///   - baseFee: Base fee
  ///   - gasPrice: Legacy gas price
  public init(baseFee: Decimal, gasPrice: Decimal) {
    let baseTip = gasPrice - baseFee
    
    self.opportunistic    = TransactionFeePrice(baseFee: baseFee, tip: baseTip, speed: .opportunistic)
    self.economy          = TransactionFeePrice(baseFee: baseFee, tip: baseTip, speed: .economy)
    self.recommended      = TransactionFeePrice(baseFee: baseFee, tip: baseTip, speed: .recommended)
    self.higherPriority   = TransactionFeePrice(baseFee: baseFee, tip: baseTip, speed: .higherPriority)
    self.highestPriority  = TransactionFeePrice(baseFee: baseFee, tip: baseTip, speed: .highestPriority)
  }
  
  init(opportunistic: TransactionFeePrice,
       economy: TransactionFeePrice,
       recommended: TransactionFeePrice,
       higherPriority: TransactionFeePrice,
       highestPriority: TransactionFeePrice) {
    self.opportunistic = opportunistic
    self.economy = economy
    self.recommended = recommended
    self.higherPriority = higherPriority
    self.highestPriority = highestPriority
  }
  
  /// Returns optimal fee that might be used for transaction(s)
  /// - Parameters:
  ///   - balance: Raw balance of account
  ///   - limit: gasLimit of transaction
  ///   - isCritical: if true - economy will not be used
  /// - Returns: optimal transactionFee
  public func optimalFee(for balance: Decimal, limit: Decimal, isCritical: Bool) -> TransactionFee {
    guard !isCritical else {
      return TransactionFee(limit: limit, price: self.recommended)
    }
    if self.recommended.canBeUsed(for: limit, balance: balance) {
      return TransactionFee(limit: limit, price: self.recommended)
    }
    if self.economy.canBeUsed(for: limit, balance: balance) {
      return TransactionFee(limit: limit, price: self.economy)
    }
    return TransactionFee(limit: limit, price: self.recommended)
  }
  
  public func options(limit: Decimal, isCritical: Bool) -> [TransactionFee] {
    var options: [TransactionFee] = [
      self.recommended,
      self.higherPriority,
      self.highestPriority
    ].map { TransactionFee(limit: limit, price: $0) }
    
    if !isCritical {
      options.insert(TransactionFee(limit: limit, price: self.economy), at: 0)
    }
    return options
  }
  
  public func replacement(currentTip: Decimal) -> TransactionFeePriceOptions {
    let minimumTip = currentTip * Decimal(1.1)
    
    let opportunistic = TransactionFeePrice(exactBaseFee: self.opportunistic.baseFee,
                                            exactTip: max(minimumTip, self.opportunistic.tip),
                                            speed: .opportunistic)
    let economy = TransactionFeePrice(exactBaseFee: self.economy.baseFee,
                                            exactTip: max(minimumTip, self.economy.tip),
                                            speed: .economy)
    let recommended = TransactionFeePrice(exactBaseFee: self.recommended.baseFee,
                                            exactTip: max(minimumTip, self.recommended.tip),
                                            speed: .recommended)
    let higherPriority = TransactionFeePrice(exactBaseFee: self.higherPriority.baseFee,
                                            exactTip: max(minimumTip, self.higherPriority.tip),
                                            speed: .higherPriority)
    let highestPriority = TransactionFeePrice(exactBaseFee: self.highestPriority.baseFee,
                                            exactTip: max(minimumTip, self.highestPriority.tip),
                                            speed: .highestPriority)
    
    return TransactionFeePriceOptions(opportunistic: opportunistic,
                                      economy: economy,
                                      recommended: recommended,
                                      higherPriority: higherPriority,
                                      highestPriority: highestPriority)
  }
}

