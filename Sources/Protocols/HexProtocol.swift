//
//  File.swift
//  
//
//  Created by Mikhail Nikanorov on 6/25/21.
//

import Foundation

public protocol HexProtocol {
  var hexString: String { get }
  init(hex: String)
}
