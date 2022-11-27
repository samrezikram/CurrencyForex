//
//  CountryCallItem.swift
//  Currency Forex
//
//  Created by Samrez Ikram on 27/11/2022.
//

import Foundation

//"idd": {
//    "root": "+4",
//    "suffixes": [
//        "7"
//    ]
//},

/// Country name info.
struct CountryCallItem {
  var root: String?
  var suffixes: [String]?
  var minLength: Int?
  var maxLength: Int?
  var mask: String?

  var code: String? {
    guard let suffixes = suffixes, suffixes.isNotEmpty else {
      return root ?? ""
    }
    return suffixes.count > 1 ? root ?? "" : String("\(root ?? "")\(suffixes.first ?? "")")
  }
  
  enum CodingKeys: String, CodingKey {
    case root
    case suffixes
    case minLength
    case maxLength
    case mask
  }
}

extension CountryCallItem: Decodable {
  
  init(from decoder: Decoder) throws {
    let values = try decoder.container(keyedBy: CodingKeys.self)
    root = try values.decodeIfPresent(String.self, forKey: .root)
    suffixes = try values.decodeIfPresent([String].self, forKey: .suffixes)
    minLength = try values.decodeIfPresent(Int.self, forKey: .minLength)
    maxLength = try values.decodeIfPresent(Int.self, forKey: .maxLength)
    mask = try values.decodeIfPresent(String.self, forKey: .mask)
  }
}
