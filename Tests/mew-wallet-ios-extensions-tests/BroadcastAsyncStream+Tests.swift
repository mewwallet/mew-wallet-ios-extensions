import Foundation
import Testing

@testable import mew_wallet_ios_extensions

@Suite("BroadcastAsyncStream tests")
struct BroadcastAsyncStreamTests {
  @Test("Should act as AsyncStream")
  func singleConsumer() async {
    await withTaskGroup(of: Void.self) { group in
      let stream = BroadcastAsyncStream<Int>()
      
      group.addTask {
        for i in 0..<10 {
          try? await Task.sleep(nanoseconds: 100_000_000)
          stream.yield(i)
        }
        stream.finish()
      }
      
      group.addTask {
        var sequience: [Int] = []
        for await value in stream {
          sequience.append(value)
        }
        
        let expected = [0, 1, 2, 3, 4, 5, 6, 7, 8, 9]
        #expect(expected == sequience)
      }
    }
  }
  
  @Test("Should broadcast to all cosumers the same")
  func multipleConsumers() async {
    await withTaskGroup(of: Void.self) { group in
      let stream = BroadcastAsyncStream<Int> { continuaton in
        group.addTask {
          for i in 0..<10 {
            try? await Task.sleep(nanoseconds: 100_000_000)
            continuaton.yield(i)
          }
          continuaton.finish()
        }
      }
      
      group.addTask {
        var sequience: [Int] = []
        for await value in stream {
          sequience.append(value)
        }
        
        let expected = [0, 1, 2, 3, 4, 5, 6, 7, 8, 9]
        #expect(expected == sequience)
      }
      
      group.addTask {
        var sequience: [Int] = []
        for await value in stream {
          sequience.append(value)
        }
        
        let expected = [0, 1, 2, 3, 4, 5, 6, 7, 8, 9]
        #expect(expected == sequience)
      }
    }
  }
  
  @Test("Should stops after all consumers disconnected")
  func resumeAfterReconnect() async {
    await withTaskGroup(of: Void.self) { group in
      let stream = BroadcastAsyncStream<Int>(bufferingPolicy: .bufferingNewest(1))
      group.addTask {
        for i in 0..<20 {
          try? await Task.sleep(nanoseconds: 100_000_000)
          let result = stream.yield(i)
          guard case .terminated = result else { continue }
          break
        }
        stream.finish()
      }
      
      group.addTask {
        var sequience: [Int] = []
        for await value in stream {
          sequience.append(value)
          if value == 9 { break }
        }
        
        let expected = [0, 1, 2, 3, 4, 5, 6, 7, 8, 9]
        #expect(expected == sequience)
      }
      
      group.addTask {
        var sequience: [Int] = []
        for await value in stream {
          sequience.append(value)
          if value == 9 { break }
        }
        
        let expected = [0, 1, 2, 3, 4, 5, 6, 7, 8, 9]
        #expect(expected == sequience)
      }
      
      group.addTask {
        try? await Task.sleep(nanoseconds: 1_550_000_000)
        var sequience: [Int] = []
        for await value in stream {
          sequience.append(value)
        }
        
        let expected: [Int] = []
        #expect(expected == sequience)
      }
    }
  }
  
  @Test("Should respect buffering policy")
  func respectBufferingPolicy() async {
    await withTaskGroup(of: Void.self) { group in
      let stream = BroadcastAsyncStream<Int>(bufferingPolicy: .bufferingNewest(1)) { continuaton in
        group.addTask {
          for i in 0..<10 {
            try? await Task.sleep(nanoseconds: 100_000_000)
            continuaton.yield(i)
          }
          continuaton.finish()
        }
      }
      
      group.addTask {
        try? await Task.sleep(nanoseconds: 650_000_000)
        var sequience: [Int] = []
        for await value in stream {
          sequience.append(value)
        }
        
        let expected = [5, 6, 7, 8, 9]
        #expect(expected == sequience)
      }
    }
  }
}
