//
//  ErrorCode.swift
//  Currency Forex
//
//  Created by Samrez Ikram on 27/11/2022.
//

import Foundation

/// Error code
enum ErrorCode: String, Codable {
  case error = "0"
  case badRequest = "400"
  case userNotAuth = "401"
  case notFound = "404"
  case tooManyRequests = "429"
  
  case invalidApiKey = "101"
  case inactiveAccount = "102"
  case invalidEndPoint = "103"
  case maxFixerApiLimit = "104"
  case subscriptionNotAvailableForFixerEndPoint = "105"
  case requestResultNotAvailable = "106"
  case invalidBaseCurrency = "201"
  case invalidCurrencySymbol = "202"
  case missingDateForFixedDateInterval = "301"
  case invalidDateForFixesDateInterval = "302"
  case invalidAmountForFixer = "403"
  case missingDateIntervalOrInvalidIntervalForFixer = "501"
  case missingStartDateOrInvalidIntervalForFixer = "502"
  case missingEndDateOrInvalidIntervalForFixer = "503"
  case invalidTimeFrameForFixer = "504"
  case tooLongTimeFrameOrBiggerThan365DaysForFixer = "505"
}
