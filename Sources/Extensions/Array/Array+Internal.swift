//
//  File.swift
//  
//
//  Created by Mikhail Nikanorov on 6/25/21.
//

import Foundation

extension Array where Element == UInt8 {
  internal var slice: ArraySlice<Element> {
    self[self.startIndex ..< self.endIndex]
  }
  
  internal init(reserveCapacity: Int) {
    self = Array<Element>()
    self.reserveCapacity(reserveCapacity)
  }
}
