//
//  File.swift
//  
//
//  Created by Mikhail Nikanorov on 2/9/22.
//

import Foundation
import Combine

public extension Publisher where Output == Decimal {
  func convert(from: CryptoUnit = .wei, to: CryptoUnit) -> Publishers.Map<Self, Output> {
    map { $0.convert(from: from, to: to) }
  }
}
