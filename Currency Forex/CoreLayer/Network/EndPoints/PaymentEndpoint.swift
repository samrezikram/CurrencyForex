//
//  PaymentEndpoint.swift
//  Currency Forex
//
//  Created by Samrez Ikram on 27/11/2022.
//

import Foundation
import Alamofire

enum PaymentEndpoint {
  case convert
  case historicalRates
  case fluctuation(access_key: String, startDate: String, endDate: String, baseCurrency: String, targetCurrencies: [String]?)
}

extension PaymentEndpoint: Endpoint {
  
  
  var path: String {
    switch self {
    case .convert:
      return "convert"
    case .historicalRates:
      return "timeseries"
    case .fluctuation(_, _, _, _, _):
      return "fluctuation"
    }
  }
  
  var method: HTTPMethod {
    switch self {
    case .convert, .historicalRates, .fluctuation:
      return .get
    }
  }
  
  var parameters: Parameters? {
    switch self {
    case .fluctuation(let access_key, let startDate, let endDate, let baseCurrency, let targetCurrencies):
      var params: [String: Any] = [:]
      let outputCurrencies = targetCurrencies?.joined(separator: ", ")
      if let outputCurrencies = outputCurrencies { params["symbols"] = outputCurrencies }
      params["access_key"] = access_key

      params["start_date"] = startDate
      params["start_date"] = startDate
      params["end_date"] = endDate
      params["base"] = baseCurrency
      return params
    default:
      return nil
    }
  }
  
  var encoding: ParameterEncoding {
    switch self {
    case .convert, .historicalRates, .fluctuation:
      return URLEncoding.default
    default:
      return JSONEncoding.default
    }
  }
  
}
