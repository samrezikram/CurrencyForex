//
//  HTTPClient.swift
//  Currency Forex
//
//  Created by Samrez Ikram on 27/11/2022.
//

import Foundation
import Alamofire


protocol HTTPClient {
  func performRequest<T: Decodable>(endpoint: Endpoint, responseModel: T.Type) async -> Result<T, ErrorItem>
}

extension HTTPClient {
  
  func performRequest<T: Decodable>(endpoint: Endpoint, responseModel: T.Type) async -> Result<T, ErrorItem> {
    
    guard let url = URL(string: String("\(endpoint.baseURL)/api/\(endpoint.path)")) else {
      return .failure(ErrorItem(code: .none, message: "Invalid url"))
    }


    let dataTask = AF.request(url, method: endpoint.method, parameters: endpoint.parameters, encoding: endpoint.encoding, headers: endpoint.header, interceptor: nil).validate().serializingData()
    let response = await dataTask.response
    guard let statusCode = response.response?.statusCode else {
      return .failure(ErrorItem(code: .none, message: "Invalid status code"))
    }
    print(statusCode)
    switch statusCode {
    case 200...299, 428:
      guard let data = response.data else {
        return .success(true as! T)
      }
      let responseData = data
      do {
        let decodedItem = try JSONDecoder().decode(responseModel, from: responseData)
        print(decodedItem)
        return .success(decodedItem)
      } catch {
        return .success(true as! T)
      }
    case 400, 402...427, 429...499:
      guard let data = response.data else {
        return .success(true as! T)
      }
      guard let decodedError = try? JSONDecoder().decode(ResponseErrorItem.self, from: data),
          let errorItem = decodedError.error else {
        return .failure(ErrorItem(code: .none, message: "Invalid decode error"))
      }
      return .failure(errorItem)
    default:
      let body: String? = response.data != nil ? String(data: response.data!, encoding: .utf8) : nil
      let details = ErrorDetailsItem(statusCode: "\(statusCode)", response: body)
      
      guard let data = response.data else {
        return .failure(ErrorItem(code: .none, message: "Invalid decode error", details: details))
      }
      do {
        let decodedError = try JSONDecoder().decode(ResponseErrorItem.self, from: data)
        if var errorItem = decodedError.error {
          errorItem.details = details
          return .failure(errorItem)
        } else {
          return .failure(ErrorItem(code: .none, message: "Invalid decode data"))
        }
      } catch {
        print(error)
        return .failure(ErrorItem(code: .none, message: "Invalid decode data"))
      }
    }
  }
  
}
