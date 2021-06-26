//
//  File.swift
//  
//
//  Created by Mikhail Nikanorov on 6/25/21.
//

import Foundation

extension Int: DataProtocol {
  public var data: Data {
    return Swift.withUnsafeBytes(of: self.bigEndian) {
      Data($0)
    }
  }
}
