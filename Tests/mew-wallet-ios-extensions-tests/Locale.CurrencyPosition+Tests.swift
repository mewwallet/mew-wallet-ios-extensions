import XCTest
import Testing

@testable import mew_wallet_ios_extensions

@Suite("Locale+CurrencyPosition tests")
struct LocaleCurrencyPositionTests {
  @Test("Should return correct prefixes and suffixes")
  func errorOnWrongType() {
    #expect(Locale(identifier: "en_US").amountPrefix(currency: .usd) == "$")
    #expect(Locale(identifier: "en_US").amountSuffix(currency: .usd) == nil)
    #expect(Locale(identifier: "en_US").amountPrefix(currency: .rub) == "RUB\u{00A0}")
    #expect(Locale(identifier: "en_US").amountSuffix(currency: .rub) == nil)
    #expect(Locale(identifier: "en_US").amountPrefix(currency: .jpy) == "¥")
    #expect(Locale(identifier: "en_US").amountSuffix(currency: .jpy) == nil)
    
    #expect(Locale(identifier: "ru_RU").amountPrefix(currency: .usd) == nil)
    #expect(Locale(identifier: "ru_RU").amountSuffix(currency: .usd) == "\u{00A0}$")
    #expect(Locale(identifier: "ru_RU").amountPrefix(currency: .rub) == nil)
    #expect(Locale(identifier: "ru_RU").amountSuffix(currency: .rub) == "\u{00A0}₽")
    #expect(Locale(identifier: "ru_RU").amountPrefix(currency: .jpy) == nil)
    #expect(Locale(identifier: "ru_RU").amountSuffix(currency: .jpy) == "\u{00A0}¥")
    
    #expect(Locale(identifier: "en_AU").amountPrefix(currency: .usd) == "USD\u{00A0}")
    #expect(Locale(identifier: "en_AU").amountSuffix(currency: .usd) == nil)
    #expect(Locale(identifier: "en_AU").amountPrefix(currency: .rub) == "RUB\u{00A0}")
    #expect(Locale(identifier: "en_AU").amountSuffix(currency: .rub) == nil)
    #expect(Locale(identifier: "en_AU").amountPrefix(currency: .jpy) == "JPY\u{00A0}")
    #expect(Locale(identifier: "en_AU").amountSuffix(currency: .jpy) == nil)
    
    #expect(Locale(identifier: "jp").amountPrefix(currency: .usd) == "$\u{00A0}")
    #expect(Locale(identifier: "jp").amountSuffix(currency: .usd) == nil)
    #expect(Locale(identifier: "jp").amountPrefix(currency: .rub) == "RUB\u{00A0}")
    #expect(Locale(identifier: "jp").amountSuffix(currency: .rub) == nil)
    #expect(Locale(identifier: "jp").amountPrefix(currency: .jpy) == "¥\u{00A0}")
    #expect(Locale(identifier: "jp").amountSuffix(currency: .jpy) == nil)
  }
}
