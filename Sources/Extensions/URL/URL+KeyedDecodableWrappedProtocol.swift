//
//  File.swift
//  
//
//  Created by Mikhail Nikanorov on 8/26/21.
//

import Foundation

extension URL: KeyedDecodableWrappedProtocol {
  public init?(wrapped: String, hex: Bool) {
    self.init(string: wrapped)
  }
}
