//
//  File.swift
//  
//
//  Created by Mikhail Nikanorov on 11/23/21.
//

import Foundation

public struct TransactionFeePriceOptions<TF: TransactionFee>: Equatable {
  public let flat: TF.T
  public let opportunistic: TF.T
  public let economy: TF.T
  public let recommended: TF.T
  public let higherPriority: TF.T
  public let highestPriority: TF.T
  
  /// Creates options with base values
  /// - Parameters:
  ///   - baseFee: Base fee
  ///   - gasPrice: Legacy gas price
  public init(baseFee: Decimal, gasPrice: Decimal) {
    let baseTip = gasPrice - baseFee
    
    self.flat             = TF.T(baseFee: baseFee, tip: baseTip, speed: .flat)
    self.opportunistic    = TF.T(baseFee: baseFee, tip: baseTip, speed: .opportunistic)
    self.economy          = TF.T(baseFee: baseFee, tip: baseTip, speed: .economy)
    self.recommended      = TF.T(baseFee: baseFee, tip: baseTip, speed: .recommended)
    self.higherPriority   = TF.T(baseFee: baseFee, tip: baseTip, speed: .higherPriority)
    self.highestPriority  = TF.T(baseFee: baseFee, tip: baseTip, speed: .highestPriority)
  }
  
  init(flat: TF.T,
       opportunistic: TF.T,
       economy: TF.T,
       recommended: TF.T,
       higherPriority: TF.T,
       highestPriority: TF.T) {
    self.flat = flat
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
  public func optimalFee(for balance: Decimal, limit: Decimal, isCritical: Bool) -> TF {
    guard !isCritical else {
      return TF(limit: limit, price: self.recommended)
    }
    if self.recommended.canBeUsed(for: limit, balance: balance) {
      return TF(limit: limit, price: self.recommended)
    }
    if self.economy.canBeUsed(for: limit, balance: balance) {
      return TF(limit: limit, price: self.economy)
    }
    return TF(limit: limit, price: self.recommended)
  }
  
  public func fee(limit: Decimal, speed: TransactionFeeSpeed) -> TF {
    switch speed {
    case .zero:               return TF(limit: limit, price: self.economy)
    case .flat:               return TF(limit: limit, price: self.flat)
    case .legacy:             return TF(limit: limit, price: self.economy)
    case .opportunistic:      return TF(limit: limit, price: self.opportunistic)
    case .economy:            return TF(limit: limit, price: self.economy)
    case .recommended:        return TF(limit: limit, price: self.recommended)
    case .higherPriority:     return TF(limit: limit, price: self.higherPriority)
    case .highestPriority:    return TF(limit: limit, price: self.highestPriority)
    }
  }
  
  public func options(limit: Decimal, isCritical: Bool) -> [TF] {
    var options: [TF] = [
      self.recommended,
      self.higherPriority,
      self.highestPriority
    ].map { TF(limit: limit, price: $0) }
    
    if !isCritical {
      options.insert(TF(limit: limit, price: self.economy), at: 0)
    }
    return options
  }
  
  public func replacement(currentTip: Decimal) -> TransactionFeePriceOptions {
    let minimumTip = currentTip * Decimal(1.1)
    
    let flat = TF.T(exactBaseFee: self.flat.baseFee,
                 exactTip: self.opportunistic.tip,
                 speed: .flat)
    let opportunistic = TF.T(exactBaseFee: self.opportunistic.baseFee,
                          exactTip: max(minimumTip, self.opportunistic.tip),
                          speed: .opportunistic)
    let economy = TF.T(exactBaseFee: self.economy.baseFee,
                    exactTip: max(minimumTip, self.economy.tip),
                    speed: .economy)
    let recommended = TF.T(exactBaseFee: self.recommended.baseFee,
                        exactTip: max(minimumTip, self.recommended.tip),
                        speed: .recommended)
    let higherPriority = TF.T(exactBaseFee: self.higherPriority.baseFee,
                           exactTip: max(minimumTip, self.higherPriority.tip),
                           speed: .higherPriority)
    let highestPriority = TF.T(exactBaseFee: self.highestPriority.baseFee,
                            exactTip: max(minimumTip, self.highestPriority.tip),
                            speed: .highestPriority)
    
    return TransactionFeePriceOptions(flat: flat,
                                      opportunistic: opportunistic,
                                      economy: economy,
                                      recommended: recommended,
                                      higherPriority: higherPriority,
                                      highestPriority: highestPriority)
  }
}

