//
//  File.swift
//  
//
//  Created by Mikhail Nikanorov on 10/21/21.
//

import Foundation
import OSLog

@available(iOS 12.0, macOS 10.14, *)
extension UUID {
  public var signpostID: OSSignpostID {
    return OSSignpostID(self.uint64uuid)
  }
}
