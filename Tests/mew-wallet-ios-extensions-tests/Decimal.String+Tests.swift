import Foundation
import Testing

@testable import mew_wallet_ios_extensions

@Suite("Decimal to String")
struct DecimalStringTests {
  @Test("Long decimal to string")
  func test_long_decimal_to_string() {
    let number0 = Decimal(string: "41025486375585300012.376715277309906263")
    #expect(number0?.decimalString == "41025486375585300012.376715277309906263")
    #expect(number0?.decimalString(locale: Locale(identifier: "ru_RU")) == "41025486375585300012,376715277309906263")
    #expect(number0?.decimalString(locale: Locale(identifier: "ja_JP")) == "41025486375585300012.376715277309906263")
    #expect(number0?.decimalString(locale: Locale(identifier: "ar_SA")) == "41025486375585300012٫376715277309906263")
    
    let number1 = Decimal(string: "0")
    #expect(number1?.decimalString == "0")
    
    let number2 = Decimal(string: "0.1")
    #expect(number2?.decimalString == "0.1")
    
    let number3 = Decimal(string: "0.0001")
    #expect(number3?.decimalString == "0.0001")
    
    let number4 = Decimal(string: "10.00")
    #expect(number4?.decimalString == "10")
    
    let number5 = Decimal(string: "-1.1")
    #expect(number5?.decimalString == "-1.1")
    
    let number6 = Decimal(string: "-0.0000001")
    #expect(number6?.decimalString == "-0.0000001")
    
    let number7 = Decimal(string: "-100000000.0000001")
    #expect(number7?.decimalString == "-100000000.0000001")
  }
}
