//
//  CountryCurrencyItem.swift
//  Currency Forex
//
//  Created by Samrez Ikram on 27/11/2022.
//

import Foundation

/// Country name info.
struct CountryCurrencyItem {
  var code: String?
  var name: String?
  var symbol: String?
  
  enum CodingKeys: String, CodingKey {
    case name
    case symbol
  }
}

extension CountryCurrencyItem: Decodable {
  
  init(from decoder: Decoder) throws {
    let values = try decoder.container(keyedBy: CodingKeys.self)
    name = try values.decodeIfPresent(String.self, forKey: .name)
    symbol = try values.decodeIfPresent(String.self, forKey: .symbol)
  }
}
