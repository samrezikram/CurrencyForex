//
//  PaymentService.swift
//  Currency Forex
//
//  Created by Samrez Ikram on 27/11/2022.
//

import Foundation
import AnyCodable
protocol PaymentService {
  /// Get authenticated user balance info.
  func accountInfo() async -> Result<Bool, ErrorItem>

}

struct PaymentServiceImpl:  HTTPClient, PaymentService {

  func accountInfo() async -> Result<Bool, ErrorItem> {
    return await performRequest(endpoint: PaymentEndpoint.accountInfo, responseModel: Bool.self)  }

}
