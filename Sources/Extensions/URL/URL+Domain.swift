//
//  File.swift
//  
//
//  Created by Mikhail Nikanorov on 9/2/22.
//

import Foundation

public extension URL {
  var domain: String? {
    guard let components = self.host?.components(separatedBy: ".").suffix(2) else { return nil }
    return components.joined(separator: ".")
  }
  
  var subdomain: String? {
    guard let components = self.host?.components(separatedBy: ".") else { return nil }
    guard components.count > 2 else { return nil }
    return components.prefix(components.count - 2).joined(separator: ".")
  }
}
