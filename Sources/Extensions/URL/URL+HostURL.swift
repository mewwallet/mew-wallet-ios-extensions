//
//  File.swift
//  
//
//  Created by Mikhail Nikanorov on 4/27/22.
//

import Foundation

extension URL {
  public var hostURL: URL? {
    var components = URLComponents()
    components.host = self.host
    components.scheme = self.scheme
    return components.url
  }
  
  public var hostAbsolutePath: String {
    return self.hostURL?.absoluteString ?? self.absoluteString
  }
}
