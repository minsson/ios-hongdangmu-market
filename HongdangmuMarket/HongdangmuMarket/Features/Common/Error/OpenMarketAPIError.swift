//
//  OpenMarketAPIError.swift
//  HongdangmuMarket
//
//  Created by minsson on 2023/05/30.
//

import Foundation

enum OpenMarketAPIError: HongdangmuErrorProtocol {
  
  case invalidURLRequest
  case invalidDataReceived
  case httpStatusCodeError(HTTPStatusCodeError)
  case custom
  
  var code: String {
    switch self {
    case .invalidURLRequest:
      return "OM100"
    case .invalidDataReceived:
      return "OM200"
    case .httpStatusCodeError(let error):
      return error.code
    case .custom:
      return "OM999"
    }
  }
  
}
