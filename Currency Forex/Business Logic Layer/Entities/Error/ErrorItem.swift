//
//  ErrorItem.swift
//  Currency Forex
//
//  Created by Samrez Ikram on 27/11/2022.
//

import Foundation
import AnyCodable

/// API Error.
struct ErrorItem: Error {
  
  var uuid: String?
  var status: Int?
  var code: ErrorCode?
  var type: String?
  var date: Date?
  var message: String?
  var messageСode: String?
  var cause: String?
  var details: ErrorDetailsItem?
  
  
  enum CodingKeys: String, CodingKey {
    case uuid
    case code
    case status
    case type
    case date = "timestamp"
    case message
    case cause
    case messageСode = "message_code"
    case details
  }
  
  init(data: Data) {
    do {
      let item = try JSONDecoder().decode(ErrorItem?.self, from: data)
      if let result = item ?? nil {
        self = result
      } else {
        self.code = .error
      }
    } catch {
      self.code = .error
    }
  }
  
  init(code: ErrorCode? = nil, message: String? = nil, details: ErrorDetailsItem? = nil) {
    self.code = code
    self.message = message
    self.details = details
  }
}

extension ErrorItem: Decodable {
  
  init(from decoder: Decoder) throws {
    let values = try decoder.container(keyedBy: CodingKeys.self)
    uuid = try values.decodeIfPresent(String.self, forKey: .uuid)
    status = try values.decodeIfPresent(Int.self, forKey: .status)
    code = try? values.decodeIfPresent(ErrorCode.self, forKey: .code)
    type = try values.decodeIfPresent(String.self, forKey: .type)
    details = try values.decodeIfPresent(ErrorDetailsItem.self, forKey: .details)
    if let strDate = try values.decodeIfPresent(String.self, forKey: .date) {
      date = strDate.toISODate()?.date

    }
//    date = try values.decodeIfPresent(Date.self, forKey: .date)
    message = try values.decodeIfPresent(String.self, forKey: .message)
    cause = try values.decodeIfPresent(String.self, forKey: .cause)
    messageСode = try values.decodeIfPresent(String.self, forKey: .messageСode)
  }
}
