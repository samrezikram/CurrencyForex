//
//  CountryItem.swift
//  Currency Forex
//
//  Created by Samrez Ikram on 27/11/2022.
//

import Foundation
import AnyCodable

/// Country info.
struct CountryItem {
  
  /// Country name
  let name: CountryNameItem?
  
  /// Country CCN3 code
  let ccn3Code: String?
  
  /// Country Alpha-2 ISO 3166-1 code
  let alpha2Code: String?
  
  /// Country Alpha-3 ISO 3166-1 code
  let alpha3Code: String?
  
  /// Flag
  let flag: String?
  
  /// Currency
  var currency: CountryCurrencyItem?
  
  /// Call
  var call: CountryCallItem?
	
	var isSelected = false

  
  enum CodingKeys: String, CodingKey {
    case name
    case flag
    case ccn3Code = "ccn3"
    case alpha2Code = "cca2"
    case alpha3Code = "cca3"
    case currency = "currencies"
    case call = "idd"
  }
}

extension CountryItem: Decodable {
  
  init(from decoder: Decoder) throws {
    let values = try decoder.container(keyedBy: CodingKeys.self)
    name = try values.decodeIfPresent(CountryNameItem.self, forKey: .name)
    ccn3Code = try values.decodeIfPresent(String.self, forKey: .ccn3Code)
    alpha2Code = try values.decodeIfPresent(String.self, forKey: .alpha2Code)
    alpha3Code = try values.decodeIfPresent(String.self, forKey: .alpha3Code)
    flag = try values.decodeIfPresent(String.self, forKey: .flag)
    let currencyData = try values.decodeIfPresent(AnyCodable.self, forKey: .currency)
    if let obj = currencyData?.value as? [String: Any], let key = obj.keys.first, let value = obj.values.first as? [String: Any] {
      let jsonData = try JSONSerialization.data(withJSONObject: value, options: [])
      if let item = try JSONDecoder().decode(CountryCurrencyItem?.self, from: jsonData) {
        currency = item
        currency?.code = key
      }
    }
    call = try values.decodeIfPresent(CountryCallItem.self, forKey: .call)
  }
}
