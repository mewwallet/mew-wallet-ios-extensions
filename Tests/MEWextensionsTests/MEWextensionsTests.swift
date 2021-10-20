import XCTest
@testable import MEWextensions

final class MEWextensionsTests: XCTestCase {
  
  func testKeyedDecodingContainerProtocolFailure() {
    struct TestStruct: Decodable {
      // MARK: - Coding Keys
      private enum CodingKeys: CodingKey {
        case value
      }
      
      let value: Decimal
      
      init(from decoder: Decoder) throws {
        let container         = try decoder.container(keyedBy: CodingKeys.self)
        let value: Decimal    = try container.decodeWrapped(String.self, forKey: .value)
        self.value = value
      }
    }
    
    let data = #"{"value":"abc"}"#.data(using: .utf8)!
    
    let decoder = JSONDecoder()
    XCTAssertThrowsError(try decoder.decode(TestStruct.self, from: data))
  }
  
  func testKeyedEncodingContainerProtocolFailure() {
    struct TestStruct: Encodable {
      // MARK: - Coding Keys
      private enum CodingKeys: CodingKey {
        case value
      }
      
      let value: Decimal
      
      func encode(to encoder: Encoder) throws {
        var container = encoder.container(keyedBy: CodingKeys.self)
        try container.encode(self.value, forKey: .value, wrapIn: Bool.self)
      }
    }
    
    let encoder = JSONEncoder()
    let testStructNotSupported = TestStruct(value: .greatestFiniteMagnitude)
    XCTAssertThrowsError(try encoder.encode(testStructNotSupported))
  }
  
  func testDecodeHex() {
    enum CodingKeys: CodingKey {
      case min
      case max
    }
    
    struct TestStruct: Decodable {
      let min: Decimal
      let max: Decimal
      
      init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
            
        min = try container.decodeWrapped(String.self, forKey: .min, decodeHex: true)
        max = try container.decodeWrapped(String.self, forKey: .max)
      }
    }
    
    let data = #"{"min":"0x1234","max":"90000"}"#.data(using: .utf8)!
    
    let decoder = JSONDecoder()
    do {
      let result = try decoder.decode(TestStruct.self, from: data)
      XCTAssertEqual(result.min, Decimal(4660))
      XCTAssertEqual(result.max, Decimal(90000))
    } catch {
      XCTFail(error.localizedDescription)
    }
  }
  
  func testDecodeHex0x() {
    enum CodingKeys: CodingKey {
      case value
      case data
    }
    
    struct TestStruct: Decodable {
      let value: Decimal
      let data: Data
      
      init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
            
        value = try container.decodeWrapped(String.self, forKey: .value, decodeHex: true)
        data = try container.decodeWrapped(String.self, forKey: .data, decodeHex: true)
      }
    }
    
    let data = #"{"value":"0x", "data":"0x"}"#.data(using: .utf8)!
    
    let decoder = JSONDecoder()
    do {
      let result = try decoder.decode(TestStruct.self, from: data)
      XCTAssertEqual(result.value, .zero)
      XCTAssertEqual(result.data, Data())
    } catch {
      XCTFail(error.localizedDescription)
    }
  }
  
  func test_URL_KeyedDecodableWrappedProtocol() {
    enum CodingKeys: CodingKey {
      case url
    }
    
    struct TestStruct: Codable {
      let url: URL
      
      init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
            
        url = try container.decodeWrapped(String.self, forKey: .url)
      }
      
      func encode(to encoder: Encoder) throws {
        var container = encoder.container(keyedBy: CodingKeys.self)
        
        try container.encode(self.url, forKey: .url, wrapIn: String.self)
      }
    }
    
    let data = #"{"url":"https:\/\/www.google.com\/search?q=let+me+google+that+for+you&client=safari"}"#.data(using: .utf8)!
    
    let decoder = JSONDecoder()
    let encoder = JSONEncoder()
    do {
      let result = try decoder.decode(TestStruct.self, from: data)
      XCTAssertEqual(result.url, URL(string: "https://www.google.com/search?q=let+me+google+that+for+you&client=safari"))
      
      let encodedData = try encoder.encode(result)
      XCTAssertEqual(data, encodedData)
    } catch {
      XCTFail(error.localizedDescription)
    }
  }
  
  func test_Decimal_KeyedEncodableWrappedProtocol() {
    enum CodingKeys: CodingKey {
      case number
    }
    
    struct TestStruct: Codable {
      let number: Decimal
      
      init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        
        number = try container.decodeWrapped(String.self, forKey: .number)
      }
      
      func encode(to encoder: Encoder) throws {
        var container = encoder.container(keyedBy: CodingKeys.self)
        
        try container.encode(self.number, forKey: .number, wrapIn: String.self)
      }
    }
    
    let data = #"{"number":"0.10890248496039656"}"#.data(using: .utf8)!
    
    let decoder = JSONDecoder()
    let encoder = JSONEncoder()
    do {
      let result = try decoder.decode(TestStruct.self, from: data)
      XCTAssertEqual(result.number, Decimal(string: "0.10890248496039656"))
      XCTAssertEqual(result.number, Decimal(wrapped: "0,10890248496039656", hex: false))
      let encodedData = try encoder.encode(result)
      XCTAssertEqual(data, encodedData)
    } catch {
      XCTFail(error.localizedDescription)
    }
  }
  
  func test_Date_KeyedEncodableWrappedProtocol() {
    enum CodingKeys: CodingKey {
      case date
    }
    
    struct TestStruct: Codable {
      let date: Date
      
      init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        
        date = try container.decodeWrapped(String.self, forKey: .date, decodeHex: true)
      }
      
      func encode(to encoder: Encoder) throws {
        var container = encoder.container(keyedBy: CodingKeys.self)
        
        try container.encode(self.date, forKey: .date, wrapIn: String.self, encodeHex: true)
      }
    }
    
    let data = #"{"date":"0x616f74a4"}"#.data(using: .utf8)!
    
    let decoder = JSONDecoder()
    let encoder = JSONEncoder()
    do {
      let result = try decoder.decode(TestStruct.self, from: data)
      XCTAssertEqual(result.date, Date(timeIntervalSince1970: 1634694308))
      let encodedData = try encoder.encode(result)
      XCTAssertEqual(data, encodedData)
    } catch {
      XCTFail(error.localizedDescription)
    }
  }
}
