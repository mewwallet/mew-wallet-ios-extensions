//
//  File.swift
//  
//
//  Created by Mikhail Nikanorov on 10/19/21.
//

import Foundation

extension Date {
  public var decimalString: String? {
    let value = UInt(self.timeIntervalSince1970.rounded(.down))
    return String(value, radix: 10, uppercase: false)
  }
}
