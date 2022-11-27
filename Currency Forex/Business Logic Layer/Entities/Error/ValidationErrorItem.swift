//
//  ValidationErrorItem.swift
//  Currency Forex
//
//  Created by Samrez Ikram on 27/11/2022.
//

import Foundation

struct ValidationErrorItem {
  
  let code: String?
  let message: String?
  let key: String?
  
  enum CodingKeys: String, CodingKey {
    case code
    case key
    case message = "string"
  }
}

extension ValidationErrorItem: Decodable {
  
  init(from decoder: Decoder) throws {
    let values = try decoder.container(keyedBy: CodingKeys.self)
    code = try values.decodeIfPresent(String.self, forKey: .code)
    message = try values.decodeIfPresent(String.self, forKey: .message)
    key = try values.decodeIfPresent(String.self, forKey: .key)
  }
}
