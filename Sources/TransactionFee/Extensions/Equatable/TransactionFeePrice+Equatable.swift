//
//  TransactionFee+Equatable.swift
//  
//
//  Created by Михаил Полев on 26.11.2021.
//

import Foundation

extension EVMTransactionFeePrice: Equatable {
  public static func == (lhs: Self, rhs: Self) -> Bool {
    return lhs.speed == rhs.speed
  }
}

extension SOLTransactionFeePrice: Equatable {
  public static func == (lhs: Self, rhs: Self) -> Bool {
    return lhs.speed == rhs.speed
  }
}
