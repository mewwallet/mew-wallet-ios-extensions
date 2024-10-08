//
//  File.swift
//  
//
//  Created by Mikhail Nikanorov on 6/25/21.
//

import Foundation

extension Data: @retroactive ExpressibleByStringLiteral {
  public init(stringLiteral value: StringLiteralType) {
    self = Data(hex: value)
  }
}
