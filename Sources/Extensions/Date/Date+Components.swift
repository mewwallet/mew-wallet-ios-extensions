//
//  File.swift
//  mew-wallet-ios-extensions
//
//  Created by Mikhail Nikanorov on 11/16/25.
//

import Foundation

public extension Date {
  /// Returns the number of whole minutes between this date and another date,
  /// calculated using the specified calendar.
  ///
  /// The calculation is calendar-aware, meaning it correctly accounts for
  /// daylight-saving changes, leap seconds, and other calendar-specific
  /// adjustments. The result is the difference in *whole* minutes.
  ///
  /// - Parameters:
  ///   - other: The date to compare against.
  ///   - calendar: The calendar used to compute the difference.
  ///              Defaults to the user's current calendar.
  /// - Returns: The number of whole minutes from `other` to `self`.
  func minutes(since other: Date, calendar: Calendar = .current) -> Int {
    calendar.dateComponents([.minute], from: other, to: self).minute ?? 0
  }
}
