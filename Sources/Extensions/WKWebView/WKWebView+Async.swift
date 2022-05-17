//
//  File.swift
//  
//
//  Created by Mikhail Nikanorov on 5/17/22.
//

import WebKit

extension WKWebView {
  @MainActor
  public func safeEvaluateJavaScript(_ javaScriptString: String) async throws -> Any? {
    return try await withCheckedThrowingContinuation { continuation in
      self.evaluateJavaScript(javaScriptString) { result, error in
        if let error = error {
          continuation.resume(throwing: error)
          return
        }
        continuation.resume(returning: result)
      }
    }
  }
}
