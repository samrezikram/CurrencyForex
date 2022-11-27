//
//  String + Estensions.swift
//  Currency Forex
//
//  Created by Samrez Ikram on 27/11/2022.
//

import Foundation

extension String {
  var isBlank: Bool {
    return self.trimmingCharacters(in: .whitespacesAndNewlines).isEmpty
  }
  
  var isNotBlank: Bool {
    return !isBlank
  }
}
extension String {
  
  func formatISODate(_ toFormat: String) -> String {
    if !isBlank {
      let dateFormatter = DateFormatter()
      dateFormatter.dateFormat = "yyyy-MM-dd"
      dateFormatter.timeZone = NSTimeZone(name: "UTC") as TimeZone?
      dateFormatter.locale = Locale(identifier: "your_loc_id")

      if let date = dateFormatter.date(from: self) {
        dateFormatter.timeZone = NSTimeZone(name: "UTC") as TimeZone?
        return date.toFormat(toFormat)
      }
    }
    return ""
  }
  
  // MARK: - Convert UTC To Local Date by passing date formats value
  func UTCToLocal(incomingFormat: String, outGoingFormat: String) -> String {
    let dateFormatter = DateFormatter()
    dateFormatter.dateFormat = incomingFormat
    dateFormatter.timeZone = TimeZone(abbreviation: "UTC")
    let dt = dateFormatter.date(from: self)
    dateFormatter.timeZone = TimeZone.current
    dateFormatter.dateFormat = outGoingFormat
    return dateFormatter.string(from: dt ?? Date())
  }
  
  // MARK: - Convert Local To UTC Date by passing date formats value
  func localToUTC(incomingFormat: String, outGoingFormat: String) -> String {
    let dateFormatter = DateFormatter()
    dateFormatter.dateFormat = incomingFormat
    dateFormatter.calendar = NSCalendar.current
    dateFormatter.timeZone = TimeZone.current
    let dt = dateFormatter.date(from: self)
    dateFormatter.timeZone = TimeZone(abbreviation: "UTC")
    dateFormatter.dateFormat = outGoingFormat
    return dateFormatter.string(from: dt ?? Date())
  }
}

extension String {
  func fromBase64() -> String? {
    guard let data = Data(base64Encoded: self) else {
      return nil
    }
    
    return String(data: data, encoding: .utf8)
  }
  
  func toBase64() -> String {
    return Data(self.utf8).base64EncodedString()
  }
}
