//
//  File.swift
//  
//
//  Created by Mikhail Nikanorov on 4/25/22.
//

import Foundation
import Combine

@available(iOS 13.0, *)
extension Publishers {
  public final class SubscribersCounter<Upstream>: Publisher where Upstream: Publisher {
    public private(set) var numberOfSubscribers = 0
    
    public typealias Output = Upstream.Output
    public typealias Failure = Upstream.Failure
    
    public let upstream: Upstream
    public let callback: ((Int) -> Void)?
    
    public init(upstream: Upstream, callback: ((Int) -> Void)?) {
      self.upstream = upstream
      self.callback = callback
    }
    
    public func receive<S>(subscriber: S) where S: Subscriber, Upstream.Failure == S.Failure, Upstream.Output == S.Input {
      self.increase()
      upstream.receive(subscriber: SubscribersCounterSubscriber<S>(counter: self, subscriber: subscriber))
    }
    
    fileprivate func increase() {
      numberOfSubscribers += 1
      self.callback?(numberOfSubscribers)
    }
    
    fileprivate func decrease() {
      numberOfSubscribers -= 1
      self.callback?(numberOfSubscribers)
    }
    
    // own subscriber is needed to intercept upstream/downstream events
    private final class SubscribersCounterSubscriber<S>: Subscriber where S: Subscriber {
      let counter: SubscribersCounter<Upstream>
      let subscriber: S
      
      init (counter: SubscribersCounter<Upstream>, subscriber: S) {
        self.counter = counter
        self.subscriber = subscriber
      }
      
      func receive(subscription: Subscription) {
        subscriber.receive(subscription: SubscribersCounterSubscription<Upstream>(counter: counter, subscription: subscription))
      }
      
      func receive(_ input: S.Input) -> Subscribers.Demand {
        return subscriber.receive(input)
      }
      
      func receive(completion: Subscribers.Completion<S.Failure>) {
        subscriber.receive(completion: completion)
      }
      
      typealias Input = S.Input
      typealias Failure = S.Failure
    }
    
    // own subcription is needed to handle cancel and decrease
    private final class SubscribersCounterSubscription<Upstream>: Subscription where Upstream: Publisher {
      let counter: SubscribersCounter<Upstream>
      let wrapped: Subscription
      
      private var cancelled = false
      init(counter: SubscribersCounter<Upstream>, subscription: Subscription) {
        self.counter = counter
        self.wrapped = subscription
      }
      
      deinit {
        guard !cancelled else { return }
        counter.decrease()
      }
      
      func request(_ demand: Subscribers.Demand) {
        wrapped.request(demand)
      }
      
      func cancel() {
        wrapped.cancel()
        guard !cancelled else { return }
        cancelled = true
        counter.decrease()
      }
    }
  }
}
