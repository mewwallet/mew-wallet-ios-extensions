//
//  File.swift
//  
//
//  Created by Mikhail Nikanorov on 5/17/22.
//

import WebKit

extension WKWebView {
  /// Equivalent apple-mobile-web-app-title
  public var appleTitle: String? {
    get async throws {
      try await self.safeEvaluateJavaScript("document.querySelector('meta[name=\"apple-mobile-web-app-title\"]').content") as? String
    }
  }
  
  /// Equivalent og:site_name
  public var siteName: String? {
    get async throws {
      try await self.safeEvaluateJavaScript("document.querySelector('meta[property=\"og:site_name\"]').content") as? String
    }
  }
  
  /// appleTitle? > siteName? > title
  public var alternateTitle: String? {
    get async {
      await withCheckedContinuation { continuation in
        Task {
          var title: String?
          do {
            // apple-mobile-web-app-title fits our needs the best
            title = try await self.appleTitle
          } catch {
            do {
              // alternatively we use og:site_name
              title = try await self.siteName
            } catch {
              // default fallback
              title = await MainActor.run(resultType: String?.self, body: {
                return self.title
              })
            }
          }
          continuation.resume(returning: title)
        }
      }
    }
  }
}
