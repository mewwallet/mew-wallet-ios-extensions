//
//  File.swift
//  
//
//  Created by Mikhail Nikanorov on 11/23/21.
//

import Foundation

public enum TransactionFeeSpeed: Hashable, Sendable {
  case zero
  case legacy
  case opportunistic
  case economy
  case recommended
  case higherPriority
  case highestPriority
  
  internal func baseFeeMultiplier(for gasPrice: Decimal) -> Decimal {
    if gasPrice.convert(to: .gwei) < Decimal(10) {
      switch self {
      case .zero:             return .zero
      case .legacy:           return Decimal(1.0)
      case .opportunistic:    return Decimal(1.0)
      case .economy:          return Decimal(1.1)
      case .recommended:      return Decimal(1.4)
      case .higherPriority:   return Decimal(1.6)
      case .highestPriority:  return Decimal(1.8)
      }
    } else {
      switch self {
      case .zero:             return .zero
      case .legacy:           return Decimal(1.0)
      case .opportunistic:    return Decimal(0.9)
      case .economy:          return Decimal(1.0)
      case .recommended:      return Decimal(1.25)
      case .higherPriority:   return Decimal(1.5)
      case .highestPriority:  return Decimal(1.75)
      }
    }
  }
  
  internal func tipMultiplier(for gasPrice: Decimal) -> Decimal {
    if gasPrice.convert(to: .gwei) <= Decimal(10) {
      switch self {
      case .zero:             return .zero
      case .legacy:           return Decimal(1.0)
      case .opportunistic:    return Decimal(1.0)
      case .economy:          return Decimal(1.1)
      case .recommended:      return Decimal(1.25)
      case .higherPriority:   return Decimal(1.5)
      case .highestPriority:  return Decimal(1.75)
      }
    } else {
      switch self {
      case .zero:             return .zero
      case .legacy:           return Decimal(1.0)
      case .opportunistic:    return Decimal(0.8)
      case .economy:          return Decimal(0.8)
      case .recommended:      return Decimal(0.8)
      case .higherPriority:   return Decimal(1.0)
      case .highestPriority:  return Decimal(1.2)
      }
    }
  }
  
  public var duration: TimeInterval {
    switch self {
    case .zero:             return .zero
    case .legacy:           return .zero
    case .opportunistic:    return 1200.0
    case .economy:          return 600.0
    case .recommended:      return 420.0
    case .higherPriority:   return 180.0
    case .highestPriority:  return 60.0
    }
  }
}
