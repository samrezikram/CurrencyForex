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
  case fluctuation
}

extension PaymentEndpoint: Endpoint {
  
  
  var path: String {
    switch self {
    case .convert:
      return "convert"
    case .historicalRates:
      return "timeseries"
    case .fluctuation:
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
