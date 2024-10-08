//
//  TransactionFee+Equatable.swift
//  
//
//  Created by Михаил Полев on 26.11.2021.
//

import Foundation

extension TransactionFeePrice: Equatable {
  public static func == (lhs: TransactionFeePrice, rhs: TransactionFeePrice) -> Bool {
    return
      lhs.speed == rhs.speed
  }
}
