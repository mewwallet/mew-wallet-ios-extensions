//
//  File.swift
//  
//
//  Created by Mikhail Nikanorov on 5/18/22.
//

import Foundation

extension URL {
  public static func googleSearch(query: String) -> URL? {
    var urlComponents = URLComponents()
    urlComponents.scheme = "https"
    urlComponents.host = "google.com"
    urlComponents.path = "/search"
    urlComponents.queryItems = [
      .init(name: "q", value: query)
    ]
    return urlComponents.url
  }
}
