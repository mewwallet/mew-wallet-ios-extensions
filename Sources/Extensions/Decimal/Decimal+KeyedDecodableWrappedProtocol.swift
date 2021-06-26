//
//  File.swift
//  
//
//  Created by Mikhail Nikanorov on 6/25/21.
//

import Foundation

extension Decimal: KeyedDecodableWrappedProtocol {
  public init?(wrapped: String) {
    self.init(string: wrapped)
  }
}
