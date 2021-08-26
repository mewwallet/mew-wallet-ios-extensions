//
//  File.swift
//  
//
//  Created by Mikhail Nikanorov on 8/26/21.
//

import Foundation

extension URL: HexProtocol {
  public var hexString: String {
    return self.absoluteString.data(using: .utf8)?.hexString ?? ""
  }
  
  public init(hex: String) {
    fatalError("Not supported yet")
  }
}
