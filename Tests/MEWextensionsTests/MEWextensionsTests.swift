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
}
