//
//  PaymentService.swift
//  Currency Forex
//
//  Created by Samrez Ikram on 27/11/2022.
//

import Foundation
import AnyCodable
protocol PaymentService {
  /// Get authenticated user balance info.
  func convert() async -> Result<Bool, ErrorItem>
  func historicalRates() async -> Result<Bool, ErrorItem>
  func fluctuation(access_key: String, startDate: String, endDate: String, baseCurrency: String, targetCurrencies: [String]?) async -> Result<RemitanceItems, ErrorItem>



}

struct PaymentServiceImpl:  HTTPClient, PaymentService {

  func convert() async -> Result<Bool, ErrorItem> {
    return await performRequest(endpoint: PaymentEndpoint.convert, responseModel: Bool.self)
  }
  
  func historicalRates() async -> Result<Bool, ErrorItem> {
    return await performRequest(endpoint: PaymentEndpoint.historicalRates, responseModel: Bool.self)
  }
  
  func fluctuation(access_key: String, startDate: String, endDate: String, baseCurrency: String, targetCurrencies: [String]?) async -> Result<RemitanceItems, ErrorItem> {
    return await performRequest(endpoint: PaymentEndpoint.fluctuation(access_key: access_key, startDate: startDate, endDate: endDate, baseCurrency: baseCurrency, targetCurrencies: targetCurrencies), responseModel: RemitanceItems.self)
  }

}
