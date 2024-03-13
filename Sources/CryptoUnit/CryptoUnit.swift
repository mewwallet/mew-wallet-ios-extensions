//
//  File.swift
//  
//
//  Created by Mikhail Nikanorov on 2/9/22.
//

import Foundation

public enum CryptoUnit: Sendable {
  case wei
  case kwei
  case mwei
  case gwei
  case szabo
  case finney
  case ether
  case kether
  case mether
  case gether
  case tether
  case custom(_ decimals: Int)
  
  public var decimals: Decimal {
    switch self {
    case .wei:
      return Decimal(1)
    case .kwei:
      return Decimal(sign: .plus, exponent: -3, significand: Decimal(1))
    case .mwei:
      return Decimal(sign: .plus, exponent: -6, significand: Decimal(1))
    case .gwei:
      return Decimal(sign: .plus, exponent: -9, significand: Decimal(1))
    case .szabo:
      return Decimal(sign: .plus, exponent: -12, significand: Decimal(1))
    case .finney:
      return Decimal(sign: .plus, exponent: -15, significand: Decimal(1))
    case .ether:
      return Decimal(sign: .plus, exponent: -18, significand: Decimal(1))
    case .kether:
      return Decimal(sign: .plus, exponent: -21, significand: Decimal(1))
    case .mether:
      return Decimal(sign: .plus, exponent: -24, significand: Decimal(1))
    case .gether:
      return Decimal(sign: .plus, exponent: -27, significand: Decimal(1))
    case .tether:
      return Decimal(sign: .plus, exponent: -30, significand: Decimal(1))
    case let .custom(decimals):
      return Decimal(sign: .plus, exponent: -decimals, significand: Decimal(1))
    }
  }
  
  public static func convert(amount: Decimal, from: CryptoUnit = .wei, to: CryptoUnit) -> Decimal {
    return amount / from.decimals * to.decimals
  }
  
  public func convert(amount: Decimal, to: CryptoUnit) -> Decimal {
    return CryptoUnit.convert(amount: amount, from: self, to: to)
  }
}
