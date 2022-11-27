//
//  Date + Estensions.swift
//  Currency Forex
//
//  Created by Samrez Ikram on 27/11/2022.
//

import Foundation
import SwiftDate

extension Date {
  
  var shortValue: String {
    let current = Date()
    if current < self + 1.hours {
      let mins = abs((current - self).minute ?? 0)
      return "\(mins) min"
    }
    if current < self + 24.hours {
      let hrs = abs((current - self).hour ?? 0)
      return "\(hrs) hours ago"
    }
    if current < self + 7.days {
      let days = abs((current - self).day ?? 0)
      return "\(days) days ago"
    }
    return self.toFormat("dd.MM.yyyy")
  }
  
  var shortestValue: String {
    let current = Date()
    if current < self + 1.hours {
      let mins = abs((current - self).minute ?? 0)
      return "\(mins) min"
    }
    if current < self + 24.hours {
      let hrs = abs((current - self).hour ?? 0)
      return "\(hrs)h"
    }
    if current < self + 7.days {
      let days = abs((current - self).day ?? 0)
      return "\(days)d"
    }
    return self.toFormat("dd MMM")
  }
  
  var short: String {
    //    Today and time
    let current = Date()
    if current < self + 24.hours {
      //      let hrs = abs((current - self).hour ?? 0)
      return "Today \(self.toFormat("hh:mm"))"
    }
    //    display date 02 Aug and time
    return self.toFormat("dd MMM")
  }
  
}

extension Date {
  
  // Convert local time to UTC (or GMT)
  func toGlobalTime() -> Date {
    let timezone = TimeZone.current
    let seconds = -TimeInterval(timezone.secondsFromGMT(for: self))
    return Date(timeInterval: seconds, since: self)
  }
  
  // Convert UTC (or GMT) to local time
  func toLocalTime() -> Date {
    let timezone = TimeZone.current
    let seconds = TimeInterval(timezone.secondsFromGMT(for: self))
    return Date(timeInterval: seconds, since: self)
  }
  
}
