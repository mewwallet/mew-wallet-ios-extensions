//
//  File.swift
//  
//
//  Created by Mikhail Nikanorov on 3/11/24.
//

import Foundation
import Testing

@testable import mew_wallet_ios_extensions

@Suite("WeakTreadSafe Tests")
struct WeakThreadSafeTests {
  
  @Test("It must allow to deinit")
  func allowDeinit() async {
    final class TestClass {
      let id: UUID
      
      init(id: UUID) {
        self.id = id
      }
    }
    
    let id = UUID()
    await withTaskGroup(of: Void.self) { group in
      let lock = WeakThreadSafe<TestClass>(nil)
      
      #expect(lock.value == nil)
      
      group.addTask {
        var object = TestClass(id: id)
        lock.value = object
        
        #expect(lock.value?.id == id)
        
        try? await Task.sleep(nanoseconds: 1_000_000_000)
      }
      
      group.addTask {
        try? await Task.sleep(nanoseconds: 500_000_000)
        #expect(lock.value?.id == id)
        try? await Task.sleep(nanoseconds: 1_000_000_000)
        #expect(lock.value == nil)
      }
    }
  }
}
