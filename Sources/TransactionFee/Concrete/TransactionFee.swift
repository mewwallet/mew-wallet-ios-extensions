//
//  File.swift
//  
//
//  Created by Mikhail Nikanorov on 1/20/22.
//

import Foundation

public protocol TransactionFee<T>: Hashable, Sendable, Equatable {
  associatedtype T: TransactionFeePrice
  var limit: Decimal { get }
  var price: T { get }
  
  /// Zero (empty) transaction fee
  static var zero: Self { get }
  
  init(limit: Decimal, price: T)
  
  mutating func update(limit: Decimal)
  
  mutating func update(price: T)
  
  func amount(decimals: Decimal?) -> Decimal
  
  func amount(decimals: Int) -> Decimal
  
  /// Validates the provided balance can pay fee
  /// - Parameters:
  ///   - balance: raw account balance
  /// - Returns: true, if balance can cover transaction fee
  func canBeUsed(for balance: Decimal) -> Bool
  
  static func == (lhs: Self, rhs: Self) -> Bool
}

public typealias EVMTransactionFee = ConcreteTransactionFee<EVMTransactionFeePrice>
public typealias SOLTransactionFee = ConcreteTransactionFee<SOLTransactionFeePrice>

public struct ConcreteTransactionFee<PRICE: TransactionFeePrice>: TransactionFee, Hashable, Equatable, Sendable {
  public var limit: Decimal
  public var price: PRICE
  
  /// Zero (empty) transaction fee
  public static var zero: Self {
    return Self(limit: .zero, price: T.zero)
  }
  
  public init(limit: Decimal, price: PRICE) {
    self.limit = limit
    self.price = price
  }
  
  public mutating func update(limit: Decimal) {
    self.limit = limit
  }
  
  public mutating func update(price: PRICE) {
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
  /// - Returns: true, if balance can cover transaction fee
  public func canBeUsed(for balance: Decimal) -> Bool {
    return self.price.canBeUsed(for: self.limit, balance: balance)
  }
  
  public static func == (lhs: Self, rhs: Self) -> Bool {
    return lhs.price == rhs.price
  }
}
