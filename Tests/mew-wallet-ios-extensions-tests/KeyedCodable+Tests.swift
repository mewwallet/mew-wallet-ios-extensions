import XCTest
import Testing

@testable import mew_wallet_ios_extensions

@Suite("Decode/EncodeWrapped tests")
struct KeyedCodableTests {
  @Test("Should throw error on wrong type")
  func errorOnWrongType() {
    struct TestStruct: Decodable {
      // MARK: - Coding Keys
      private enum CodingKeys: CodingKey {
        case value
      }
      
      let value: Decimal
      
      init(from decoder: any Decoder) throws {
        let container         = try decoder.container(keyedBy: CodingKeys.self)
        let value: Decimal    = try container.decodeWrapped(String.self, forKey: .value)
        self.value = value
      }
    }
    
    let data = #"{"value":"abc"}"#.data(using: .utf8)!
    
    let decoder = JSONDecoder()
    #expect(throws: DecodingError.self) { try decoder.decode(TestStruct.self, from: data) }
  }
  
  @Test("Should throw error on unsupported range")
  func errorOnWrongRange() {
    struct TestStruct: Encodable {
      // MARK: - Coding Keys
      private enum CodingKeys: CodingKey {
        case value
      }
      
      let value: Decimal
      
      func encode(to encoder: any Encoder) throws {
        var container = encoder.container(keyedBy: CodingKeys.self)
        try container.encode(self.value, forKey: .value, wrapIn: Bool.self)
      }
    }
    
    let encoder = JSONEncoder()
    let testStructNotSupported = TestStruct(value: .greatestFiniteMagnitude)
    #expect(throws: EncodingError.self) { try encoder.encode(testStructNotSupported) }
  }
  
  @Test("Decode hex")
  func successDecodeHex() throws {
    enum CodingKeys: CodingKey {
      case min
      case max
    }
    
    struct TestStruct: Decodable {
      let min: Decimal
      let max: Decimal
      
      init(from decoder: any Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
            
        min = try container.decodeWrapped(String.self, forKey: .min, decodeHex: true)
        max = try container.decodeWrapped(String.self, forKey: .max)
      }
    }
    
    let data = #"{"min":"0x1234","max":"90000"}"#.data(using: .utf8)!
    
    let decoder = JSONDecoder()
    let result = try #require(try decoder.decode(TestStruct.self, from: data))
    #expect(result.min == Decimal(4660))
    #expect(result.max == Decimal(90000))
  }
  
  @Test("Decode 0x hex string")
  func successDecodeHex0x() throws {
    enum CodingKeys: CodingKey {
      case value
      case data
    }
    
    struct TestStruct: Decodable {
      let value: Decimal
      let data: Data
      
      init(from decoder: any Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
            
        value = try container.decodeWrapped(String.self, forKey: .value, decodeHex: true)
        data = try container.decodeWrapped(String.self, forKey: .data, decodeHex: true)
      }
    }
    
    let data = #"{"value":"0x", "data":"0x"}"#.data(using: .utf8)!
    
    let decoder = JSONDecoder()
    let result = try #require(try decoder.decode(TestStruct.self, from: data))
    #expect(result.value == .zero)
    #expect(result.data == Data())
  }
  
  @Test("Encode/Decode URL")
  func successURL() throws {
    enum CodingKeys: CodingKey {
      case url
    }
    
    struct TestStruct: Codable {
      let url: URL
      
      init(from decoder: any Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
            
        url = try container.decodeWrapped(String.self, forKey: .url)
      }
      
      func encode(to encoder: any Encoder) throws {
        var container = encoder.container(keyedBy: CodingKeys.self)
        
        try container.encode(self.url, forKey: .url, wrapIn: String.self)
      }
    }
    
    let data = #"{"url":"https:\/\/www.google.com\/search?q=let+me+google+that+for+you&client=safari"}"#.data(using: .utf8)!
    
    let decoder = JSONDecoder()
    let encoder = JSONEncoder()
    
    let result = try #require(try decoder.decode(TestStruct.self, from: data))
    #expect(result.url == URL(string: "https://www.google.com/search?q=let+me+google+that+for+you&client=safari"))
    
    let encodedData = try #require(try encoder.encode(result))
    #expect(data == encodedData)
  }
  
  @Test("Encode/Decode Decimal")
  func successDecimal() throws {
    enum CodingKeys: CodingKey {
      case number
    }
    
    struct TestStruct: Codable {
      let number: Decimal
      
      init(from decoder: any Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        
        number = try container.decodeWrapped(String.self, forKey: .number)
      }
      
      func encode(to encoder: any Encoder) throws {
        var container = encoder.container(keyedBy: CodingKeys.self)
        
        try container.encode(self.number, forKey: .number, wrapIn: String.self)
      }
    }
    
    let data = #"{"number":"0.10890248496039656"}"#.data(using: .utf8)!
    
    let decoder = JSONDecoder()
    let encoder = JSONEncoder()
    
    let result = try #require(try decoder.decode(TestStruct.self, from: data))
    #expect(result.number == Decimal(string: "0.10890248496039656"))
    #expect(result.number == Decimal(wrapped: "0,10890248496039656", hex: false))
    let encodedData = try #require(try encoder.encode(result))
    #expect(data == encodedData)
  }
  
  @Test("Encode/Decode Date")
  func successDate() throws {
    enum CodingKeys: CodingKey {
      case date
    }
    
    struct TestStruct: Codable {
      let date: Date
      
      init(from decoder: any Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        
        date = try container.decodeWrapped(String.self, forKey: .date, decodeHex: true)
      }
      
      func encode(to encoder: any Encoder) throws {
        var container = encoder.container(keyedBy: CodingKeys.self)
        
        try container.encode(self.date, forKey: .date, wrapIn: String.self, encodeHex: true)
      }
    }
    
    let data = #"{"date":"0x616f74a4"}"#.data(using: .utf8)!
    
    let decoder = JSONDecoder()
    let encoder = JSONEncoder()
    
    let result = try #require(try decoder.decode(TestStruct.self, from: data))
    #expect(result.date == Date(timeIntervalSince1970: 1634694308))
    let encodedData = try #require(try encoder.encode(result))
    #expect(data == encodedData)
  }
}
