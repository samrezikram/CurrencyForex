//
//  ResponseErrorItem.swift
//  Currency Forex
//
//  Created by Samrez Ikram on 27/11/2022.
//

import Foundation

/// Response error info
struct ResponseErrorItem: Decodable {
  
  let error: ErrorItem?
  
  enum CodingKeys: String, CodingKey {
    case error
  }
  
  init(from decoder: Decoder) throws {
    let container = try decoder.container(keyedBy: CodingKeys.self)
    error = try container.decodeIfPresent(ErrorItem.self, forKey: .error)
  }
  
  init(error: ErrorItem?) {
    self.error = error
  }
}
