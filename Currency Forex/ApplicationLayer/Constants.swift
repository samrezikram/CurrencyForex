//
//  Constants.swift
//  Currency Forex
//
//  Created by Samrez Ikram on 26/11/2022.
//

import Foundation
import UIKit
struct Constants {
  
  struct Network {
    struct API {
      static let version = "v0"
      static let baseUrl = "https://data.fixer.io/"
      static let apiKey = Environment.apiKey
    }
  }
  
  struct UI {
    struct Color {
      static let primaryWhite = #colorLiteral(red: 1, green: 1, blue: 1, alpha: 1)
      static let primaryPurpleColor = #colorLiteral(red: 0.4390000105, green: 0.3389999866, blue: 0.9720000029, alpha: 1)
      static let primaryGradientColors = [#colorLiteral(red: 0.01176470588, green: 0.6862745098, blue: 0.9921568627, alpha: 1), #colorLiteral(red: 0.4431372549, green: 0.3294117647, blue: 1, alpha: 1)]
    }
  }
  
  struct APP {
    static let currentLocale = "en_US"
    static let debounceInputInterval = 500
    static let debounceInputRquestInterval = 1500
  }
}
