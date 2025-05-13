//
//  File.swift
//
//
//  Created by Mikhail Nikanorov on 2/9/22.
//

import Foundation

/// Represents various cryptocurrency units for Bitcoin and Ethereum.
/// Implements the `Sendable` protocol for safe concurrent use.
public enum CryptoUnit: Sendable {
  // MARK: Bitcoin units
  /// Smallest unit of Bitcoin
  case satoshi
  /// Standard unit of Bitcoin (1e+8 satoshis)
  case bitcoin
  
  // MARK: Ethereum
  /// Smallest unit of Ethereum
  case wei
  /// 1,000 wei
  case kwei
  /// 1,000,000 wei (1e+6)
  case mwei
  /// 1,000,000,000 wei (1e+9)
  case gwei
  /// 1e+12 wei
  case szabo
  /// 1e+15 wei
  case finney
  /// Standard unit of Ethereum (1e+18 wei)
  case ether
  /// 1e+21 wei (Kilo Ether)
  case kether
  /// 1e+24 wei (Mega Ether)
  case mether
  /// 1e+27 wei (Giga Ether)
  case gether
  /// 1e+30 wei (Tera Ether)
  case tether
  /// Custom unit with a specified number of decimal places
  case custom(_ decimals: Int)
  
  /// Returns the number of decimal places for the given unit.
  /// Uses a `Decimal` value to represent the scale factor.
  public var decimals: Decimal {
    switch self {
      // MARK: Bitcoin units
    case .satoshi:
      // 1 satoshi
      return Decimal(1)
      
    case .bitcoin:
      // 1 Bitcoin equals 100,000,000 Satoshis (1e+8)
      return Decimal(sign: .plus, exponent: -8, significand: Decimal(1))
      
      // MARK: Ethereum units
    case .wei:
      // 1 wei
      return Decimal(1)
      
    case .kwei:
      // 1e+3 wei
      return Decimal(sign: .plus, exponent: -3, significand: Decimal(1))
      
    case .mwei:
      // 1e+6 wei
      return Decimal(sign: .plus, exponent: -6, significand: Decimal(1))
      
    case .gwei:
      // 1e+9 wei
      return Decimal(sign: .plus, exponent: -9, significand: Decimal(1))
      
    case .szabo:
      // 1e+12 wei
      return Decimal(sign: .plus, exponent: -12, significand: Decimal(1))
      
    case .finney:
      // 1e+15 wei
      return Decimal(sign: .plus, exponent: -15, significand: Decimal(1))
      
    case .ether:
      // 1e+18 wei
      return Decimal(sign: .plus, exponent: -18, significand: Decimal(1))
      
    case .kether:
      // 1e+21 wei
      return Decimal(sign: .plus, exponent: -21, significand: Decimal(1))
      
    case .mether:
      // 1e+24 wei
      return Decimal(sign: .plus, exponent: -24, significand: Decimal(1))
      
    case .gether:
      // 1e+27 wei
      return Decimal(sign: .plus, exponent: -27, significand: Decimal(1))
      
    case .tether:
      // 1e+30 wei
      return Decimal(sign: .plus, exponent: -30, significand: Decimal(1))
      
    case let .custom(decimals):
      // Custom unit with a variable number of decimal places
      return Decimal(sign: .plus, exponent: -decimals, significand: Decimal(1))
    }
  }
  
  /// Converts a specified amount from one unit to another.
  ///
  /// - Parameters:
  ///   - amount: The numerical value to convert.
  ///   - from: The source unit (default: wei).
  ///   - to: The target unit.
  /// - Returns: The converted amount as a `Decimal`.
  public static func convert(amount: Decimal, from: CryptoUnit = .wei, to: CryptoUnit) -> Decimal {
    return amount / from.decimals * to.decimals
  }
  
  /// Converts an amount from the current unit to another specified unit.
  ///
  /// - Parameters:
  ///   - amount: The numerical value to convert.
  ///   - to: The target unit.
  /// - Returns: The converted amount as a `Decimal`.
  public func convert(amount: Decimal, to: CryptoUnit) -> Decimal {
    return CryptoUnit.convert(amount: amount, from: self, to: to)
  }
}
