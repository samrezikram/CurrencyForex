//
//  ErrorDetailsItem.swift
//  Currency Forex
//
//  Created by Samrez Ikram on 27/11/2022.
//

import Foundation

struct ErrorDetailsItem {
  
  let response: String?
  let statusCode: String?
  
  enum CodingKeys: String, CodingKey {
    case response
    case statusCode = "status_code"
  }
  
  init(statusCode: String? = nil, response: String? = nil) {
    self.statusCode = statusCode
    self.response = response
  }
}

extension ErrorDetailsItem: Decodable {
  
  init(from decoder: Decoder) throws {
    let values = try decoder.container(keyedBy: CodingKeys.self)
    response = try values.decodeIfPresent(String.self, forKey: .response)
    statusCode = try values.decodeIfPresent(String.self, forKey: .statusCode)
  }
}
