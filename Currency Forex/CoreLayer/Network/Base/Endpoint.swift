//
//  Endpoint.swift
//  Currency Forex
//
//  Created by Samrez Ikram on 27/11/2022.
//

import Foundation
import Alamofire

protocol Endpoint {
  var baseURL: String { get }
  var version: String { get }
  var path: String { get }
  var method: HTTPMethod { get }
  var header: [String: String]? { get }
  var parameters: Parameters? { get }
  var interceptor: RequestInterceptor? { get }
  var encoding: ParameterEncoding { get }
}

extension Endpoint {
  
  var baseURL: String {
    return Constants.Network.API.baseUrl
  }
  
  var version: String {
    return Constants.Network.API.version
  }
  
  var header: [String: String]? {
    return [
      "Content-Type": "application/json;charset=utf-8",
      "access_key": Constants.Network.API.apiKey
    ]
  }
  
  var method: HTTPMethod {
    return .get
  }
  
  var interceptor: RequestInterceptor? {
    return nil
  }
  
  var parameters: Parameters? {
    return nil
  }
  
}
