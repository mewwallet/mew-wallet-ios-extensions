//
//  File.swift
//  
//
//  Created by Mikhail Nikanorov on 1/20/22.
//

import Foundation

extension TransactionFee: Equatable {
  public static func == (lhs: TransactionFee, rhs: TransactionFee) -> Bool {
    return
      lhs.price == rhs.price
  }
}
