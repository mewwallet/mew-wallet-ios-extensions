//
//  File.swift
//  
//
//  Created by Mikhail Nikanorov on 5/3/23.
//

import Foundation

extension BundledDecimal {
  public struct Decimal: Sendable, Hashable, Equatable {
    public enum Symbol: Sendable, Hashable, Equatable {
      case empty
      case fiat(FiatCurrency)
      case crypto(String)
      
      public var rawValue: String {
        switch self {
        case .empty:                return ""
        case .fiat(let currency):   return currency.rawValue
        case .crypto(let symbol):   return symbol
        }
      }
    }
    public let decimal: Foundation.Decimal
    public let string: String
    public let symbol: Symbol
    
    // MARK: ZERO
    
    public static func zero(symbol: String?) -> Self {
      return Self.init(.zero, symbol: symbol)
    }
    
    public static func zero(currency: FiatCurrency?) -> Self {
      return Self.init(.zero, currency: currency)
    }
    
    public static func zero(symbol: BundledDecimal.Decimal.Symbol?) -> Self {
      return Self.init(.zero, symbol: symbol ?? .empty)
    }
    
    // MARK: String
    
    public init?(_ string: String, symbol: String?) {
      guard let decimal = Foundation.Decimal(wrapped: string, hex: false) else { return nil }
      self.init(decimal, symbol: symbol)
    }
    
    public init?(hex: String, symbol: String?) {
      guard let decimal = Foundation.Decimal(wrapped: hex, hex: true) else { return nil }
      self.init(decimal, symbol: symbol)
    }
    
    public init?(_ string: String, currency: FiatCurrency?) {
      guard let decimal = Foundation.Decimal(wrapped: string, hex: false) else { return nil }
      self.init(decimal, currency: currency)
    }
    
    public init?(hex: String, currency: FiatCurrency?) {
      guard let decimal = Foundation.Decimal(wrapped: hex, hex: true) else { return nil }
      self.init(decimal, currency: currency)
    }
    
    public init?(string: String, symbol: Symbol) {
      guard let decimal = Foundation.Decimal(wrapped: string, hex: false) else { return nil }
      self.init(decimal, symbol: symbol)
    }
    
    public init?(hex: String, symbol: Symbol) {
      guard let decimal = Foundation.Decimal(wrapped: hex, hex: true) else { return nil }
      self.init(decimal, symbol: symbol)
    }
    
    // MARK: Decimal
    
    public init(_ decimal: Foundation.Decimal, symbol: String?) {
      self.decimal = decimal
      self.string = decimal.decimalString
      if let symbol {
        self.symbol = .crypto(symbol)
      } else {
        self.symbol = .empty
      }
    }
    
    public init(_ decimal: Foundation.Decimal, currency: FiatCurrency?) {
      self.decimal = decimal
      self.string = decimal.decimalString
      if let currency {
        self.symbol = .fiat(currency)
      } else {
        self.symbol = .empty
      }
    }
    
    public init(_ decimal: Foundation.Decimal, symbol: Symbol) {
      self.decimal = decimal
      self.string = decimal.decimalString
      self.symbol = symbol
    }
    
    public static func + (lhs: BundledDecimal.Decimal, rhs: BundledDecimal.Decimal) -> BundledDecimal.Decimal {
      guard lhs.symbol == rhs.symbol else { return lhs }
      return BundledDecimal.Decimal(lhs.decimal + rhs.decimal, symbol: lhs.symbol)
    }
    
    public static func + (lhs: BundledDecimal.Decimal, rhs: BundledDecimal.Decimal?) -> BundledDecimal.Decimal {
      guard let rhs else { return lhs }
      return lhs + rhs
    }
    
    public static func + (lhs: BundledDecimal.Decimal?, rhs: BundledDecimal.Decimal) -> BundledDecimal.Decimal {
      guard let lhs else { return rhs }
      return lhs + rhs
    }
  }
}
