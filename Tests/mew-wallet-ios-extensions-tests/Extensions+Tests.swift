import Foundation
import Testing

@testable import mew_wallet_ios_extensions

@Suite("Extension tests")
struct ExtensionTests {
  @Test("URL+Domain")
  func domains() {
    let host0 = URL(string: "https://google.com")!
    let host1 = URL(string: "https://bbc.co.uk")!
    let host2 = URL(string: "https://www.myetherwallet.com")!
    let host3 = URL(string: "https://testsubdomain.test.website")!
    
    #expect(host0.domain == "google.com")
    #expect(host0.subdomain == nil)
    
    #expect(host1.domain == "co.uk")
    #expect(host1.subdomain == "bbc")
    
    #expect(host2.domain == "myetherwallet.com")
    #expect(host2.subdomain == "www")
    
    #expect(host3.domain == "test.website")
    #expect(host3.subdomain == "testsubdomain")
  }
}
