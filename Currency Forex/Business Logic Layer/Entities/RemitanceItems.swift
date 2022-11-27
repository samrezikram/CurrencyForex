//
//  RemitanceItems.swift
//  Currency Forex
//
//  Created by Samrez Ikram on 27/11/2022.
//

import Foundation

struct RemitanceItems {
    
  var success: Bool?
  var fluctuation: Bool?
  var startDate: String?
  var endDate: String?
  var base: String?
  let rates: [Rate]?
    
  enum CodingKeys: String, CodingKey {
    case success, fluctuation
    case startDate = "start_date"
    case endDate = "end_date"
    case base, rates
  }
}

extension RemitanceItems: Codable {
    
  init(from decoder: Decoder) throws {
    let values = try decoder.container(keyedBy: CodingKeys.self)
    success = try values.decodeIfPresent(Bool.self, forKey: .success)
    fluctuation = try values.decodeIfPresent(Bool.self, forKey: .fluctuation)
    startDate = try values.decodeIfPresent(String.self, forKey: .startDate)
    endDate = try values.decodeIfPresent(String.self, forKey: .endDate)
    rates = try values.decodeIfPresent([Rate].self, forKey: .rates)

  }
    
  public func encode(to encoder: Encoder) throws {
    var container = encoder.container(keyedBy: CodingKeys.self)
    try container.encode(success, forKey: .success)
    try container.encode(fluctuation, forKey: .fluctuation)
    try container.encodeIfPresent(startDate, forKey: .startDate)
    try container.encodeIfPresent(endDate, forKey: .endDate)

  }
}


struct Rate: Codable {
    let startRate, endRate, change, changePct: Double

    enum CodingKeys: String, CodingKey {
        case startRate = "start_rate"
        case endRate = "end_rate"
        case change
        case changePct = "change_pct"
    }
}
