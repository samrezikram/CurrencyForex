//
//  Helpers.swift
//  JinglePay
//
//  Created by Samrez Ikram on 14.07.2020.
//  Copyright © 2020 Jingle Pay. All rights reserved.
//

import UIKit
import Foundation

/// Application helper
class AppHelper: NSObject {
  
  public static let shared = AppHelper()
  
  
  /// List of countries
  var countries: [CountryItem] = []
  
  /// Load default data
  func initData() {
    loadCountries()
  }
  
  
  /// Get currency name.
  ///
  /// - Parameter code: Currency code
  /// - Returns: Currency name.
  func currencyName(withCode code: String) -> String? {
    let currencies = countries.compactMap { $0.currency }
    return currencies.first(where: { $0.code == code })?.name
  }
  
  /// Get country code by currency code.
  ///
  /// - Parameter code: Currency code
  /// - Returns: Country code.
  func countryCode(withCurrencyCode code: String) -> String? {
    let country = countries.first(where: { $0.currency?.code == code })
    return country?.alpha2Code
  }
  
  func currencyCode(withCountryCode code: String) -> String? {
    let country = countries.first(where: { $0.alpha2Code == code })
    return country?.currency?.code
  }
  
  func countryAlpha3Code(withAlpha2Code code: String) -> String? {
    let country = countries.first(where: { $0.alpha2Code == code })
    return country?.alpha3Code
  }
  
  private func readJSONFromFile(fileName: String) -> Any? {
    var json: Any?
    if let path = Bundle.main.path(forResource: fileName, ofType: "json") {
      do {
        let fileUrl = URL(fileURLWithPath: path)
        // Getting data from JSON file using the file URL
        let data = try Data(contentsOf: fileUrl, options: .mappedIfSafe)
        json = try? JSONSerialization.jsonObject(with: data)
      } catch {
      }
    }
    return json
  }
  
  /// Load countries.
  private func loadCountries() {
    DispatchQueue.global(qos: .background).async {
      if let url = Bundle.main.url(forResource: "countries_data", withExtension: "json") {
        do {
          let data = try Data(contentsOf: url)
          let decoder = JSONDecoder()
          self.countries = try decoder.decode([CountryItem].self, from: data).sorted(by: { (($0.name?.common ?? "") < ($1.name?.common ?? "")) || $0.alpha2Code == Constants.APP.defaultCCA2Code })
        } catch {
          print("error:\(error)")
        }
      }
    }
  }
  
  var currencyFormatter: NumberFormatter {
    get {
      let formatter = NumberFormatter()
      formatter.generatesDecimalNumbers = true
      formatter.minimumFractionDigits = 2
      formatter.maximumFractionDigits = 2
      formatter.numberStyle = NumberFormatter.Style.currencyAccounting
      formatter.currencySymbol = ""
      formatter.usesGroupingSeparator = false
      formatter.locale = Locale(identifier: "en_US")
      formatter.decimalSeparator = "."
      return formatter
    }
  }
  
}
