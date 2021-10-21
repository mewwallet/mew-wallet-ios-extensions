//
//  File.swift
//  
//
//  Created by Mikhail Nikanorov on 10/21/21.
//

import Foundation

extension UUID {
  public var uint64uuid: UInt64 {
    var a: UInt64 = 0
    a |= UInt64(self.uuid.0)
    a |= UInt64(self.uuid.1) << 8
    a |= UInt64(self.uuid.2) << (8 * 2)
    a |= UInt64(self.uuid.3) << (8 * 3)
    a |= UInt64(self.uuid.4) << (8 * 4)
    a |= UInt64(self.uuid.5) << (8 * 5)
    a |= UInt64(self.uuid.6) << (8 * 6)
    a |= UInt64(self.uuid.7) << (8 * 7)
    
    var b: UInt64 = 0
    b |= UInt64(self.uuid.8)
    b |= UInt64(self.uuid.9) << 8
    b |= UInt64(self.uuid.10) << (8 * 2)
    b |= UInt64(self.uuid.11) << (8 * 3)
    b |= UInt64(self.uuid.12) << (8 * 4)
    b |= UInt64(self.uuid.13) << (8 * 5)
    b |= UInt64(self.uuid.14) << (8 * 6)
    b |= UInt64(self.uuid.15) << (8 * 7)
    
    return a ^ b
  }
}
