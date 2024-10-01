//
//  File.swift
//  
//
//  Created by Mikhail Nikanorov on 5/17/22.
//

import WebKit

extension WKWebView {
  @MainActor
  fileprivate func safeEvaluateJavaScript(_ javaScriptString: String) async throws -> UnknownSendable<Any?> {
    return try await withCheckedThrowingContinuation { continuation in
      self.evaluateJavaScript(javaScriptString) { result, error in
        if let error = error {
          continuation.resume(throwing: error)
          return
        }
        continuation.resume(returning: UnknownSendable(value: result))
      }
    }
  }
  
  @MainActor
  public func safeEvaluateJavaScript(_ javaScriptString: String) async throws -> Any? {
    let result: UnknownSendable<Any?> = try await self.safeEvaluateJavaScript(javaScriptString)
    return result.value
  }
}
