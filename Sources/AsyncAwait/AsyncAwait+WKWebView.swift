//
//  File.swift
//  
//
//  Created by Mitya on 5/17/22.
//

import WebKit

// Can it live here?
extension WKWebView {
  @discardableResult
  public func evaluateJavaScriptAsync(_ str: String) async throws -> Any? {
    return try await withCheckedThrowingContinuation { continuation in
      DispatchQueue.main.async {
        self.evaluateJavaScript(str) { data, error in
          if error != nil {
            continuation.resume(returning: nil)
          } else {
            continuation.resume(returning: data)
          }
        }
      }
    }
  }
}
