//
//  File.swift
//  
//
//  Created by Mikhail Nikanorov on 5/8/23.
//

import Foundation

/// Stores symboled `crypto` and `fiat` amounts
public struct BundledDecimal: Sendable, Hashable, Equatable {
  /// Crypto amount with symbol
  public let crypto: BundledDecimal.Decimal
  /// Fiat amount with currency
  public let fiat: BundledDecimal.Decimal?
  
  public static func zero(symbol: String, currency: FiatCurrency?) -> BundledDecimal {
    return .init(crypto: .zero(symbol: symbol), fiat: .zero(currency: currency))
  }
  
  internal init(crypto: BundledDecimal.Decimal, fiat: BundledDecimal.Decimal?) {
    self.crypto = crypto
    self.fiat = fiat
  }
  
  // MARK: - Decimal
  
  public init(crypto: (decimal: Foundation.Decimal, symbol: String?),
              fiat: (decimal: Foundation.Decimal, currency: FiatCurrency?)?) {
    self.crypto = BundledDecimal.Decimal(crypto.decimal, symbol: crypto.symbol)
    guard let fiat else {
      self.fiat = nil
      return
    }
    self.fiat = Decimal(fiat.decimal, currency: fiat.currency)
  }
  
  public init(crypto: (decimal: Foundation.Decimal, symbol: String?),
              fiat: BundledDecimal.Decimal?) {
    self.init(crypto: BundledDecimal.Decimal(crypto.decimal, symbol: crypto.symbol),
              fiat: fiat)
  }
  
  public init(crypto: BundledDecimal.Decimal,
              fiat: (decimal: Foundation.Decimal, currency: FiatCurrency?)?) {
    self.crypto = crypto
    guard let fiat else {
      self.fiat = nil
      return
    }
    self.fiat = Decimal(fiat.decimal, currency: fiat.currency)
  }
  
  // MARK: - String
  
  public init?(crypto: (string: String, symbol: String?),
               fiat: (string: String, currency: FiatCurrency?)?) {
    guard let crypto = BundledDecimal.Decimal(crypto.string, symbol: crypto.symbol) else { return nil }
    self.crypto = crypto
    guard let fiat else {
      self.fiat = nil
      return
    }
    self.fiat = Decimal(fiat.string, currency: fiat.currency)
  }
  
  public init?(crypto: (string: String, symbol: String?),
               fiat: BundledDecimal.Decimal?) {
    guard let crypto = Decimal(crypto.string, symbol: crypto.symbol) else { return nil }
    self.init(crypto: crypto, fiat: fiat)
  }
  
  public init?(crypto: BundledDecimal.Decimal,
               fiat: (string: String, currency: FiatCurrency?)?) {
    self.crypto = crypto
    guard let fiat else {
      self.fiat = nil
      return
    }
    self.fiat = Decimal(fiat.string, currency: fiat.currency)
  }
  
  public static func + (lhs: BundledDecimal, rhs: BundledDecimal) -> BundledDecimal {
    guard lhs.crypto.symbol == rhs.crypto.symbol else { return lhs }
    let crypto = lhs.crypto + rhs.crypto
    var fiat: BundledDecimal.Decimal? = nil
    if let lhsFiat = lhs.fiat {
      fiat = lhsFiat + rhs.fiat
    } else if let rhsFiat = rhs.fiat {
      fiat = lhs.fiat + rhsFiat
    }
    return BundledDecimal(crypto: crypto, fiat: fiat)
  }
}
