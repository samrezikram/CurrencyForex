//
//  Environment.swift
//  JinglePay
//
//  Created by Samrez Ikram on 07/06/2022.
//  Copyright © 2022 Jingle Pay. All rights reserved.
//

// Environment.swift

import Foundation

public enum Environment {
	// MARK: - Keys
	enum Keys {
		enum Plist {
			static let apiKey = "API_KEY"
		}
	}

	// MARK: - Plist
	private static let infoDictionary: [String: Any] = {
		guard let dict = Bundle.main.infoDictionary else {
			fatalError("Plist file not found")
		}
		return dict
	}()

	// MARK: - Plist values
  static let apiKey: String = {
    guard let config = Environment.infoDictionary[Keys.Plist.apiKey] as? String else {
      fatalError("Fixer API KEY not set in plist for this environment")
    }
    return config
  }()
  
}
