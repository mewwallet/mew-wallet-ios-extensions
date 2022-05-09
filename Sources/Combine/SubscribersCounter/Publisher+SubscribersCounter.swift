//
//  File.swift
//  
//
//  Created by Mikhail Nikanorov on 4/25/22.
//

import Foundation
import Combine

@available(iOS 13.0, *)
extension Publisher {
  public func countingSubscribers(_ callback: ((Int) -> Void)? = nil) -> Publishers.SubscribersCounter<Self> {
    return Publishers.SubscribersCounter<Self>(upstream: self, callback: callback)
  }
}
