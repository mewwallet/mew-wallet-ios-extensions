//
//  File.swift
//  mew-wallet-ios-extensions
//
//  Created by Mikhail Nikanorov on 10/1/24.
//

import Foundation

public struct UnknownSendable<T>: @unchecked Sendable {
  let value: T
  
  public init(value: T) {
    self.value = value
  }
}
