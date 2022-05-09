//
//  File.swift
//  
//
//  Created by Mikhail Nikanorov on 5/5/22.
//

import Foundation

extension URL {
  public var sanitized: URL? {
    guard var components = URLComponents(url: self, resolvingAgainstBaseURL: true) else { return nil }
    if components.path == "" {
      components.path = "/"
    }
    return components.url
  }
}
