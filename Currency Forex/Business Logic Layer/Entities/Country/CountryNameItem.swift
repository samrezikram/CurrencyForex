//
//  CountryNameItem.swift
//  Currency Forex
//
//  Created by Samrez Ikram on 27/11/2022.
//

import Foundation

/// Country name info.
struct CountryNameItem {
  var common: String?
  var official: String?
  
  enum CodingKeys: String, CodingKey {
    case common
    case official
  }
}

extension CountryNameItem: Decodable {
  
  init(from decoder: Decoder) throws {
    let values = try decoder.container(keyedBy: CodingKeys.self)
    common = try values.decodeIfPresent(String.self, forKey: .common)
    official = try values.decodeIfPresent(String.self, forKey: .official)
  }
}
