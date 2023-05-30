//
//  OpenMarketAPIError.swift
//  HongdangmuMarket
//
//  Created by minsson on 2023/05/30.
//

import Foundation

enum OpenMarketAPIError: HongdangmuErrorProtocol {
  
  case httpStatusCodeError(HTTPStatusCodeError)
  case invalidURLRequest
  case custom
  
  var code: String {
      switch self {
      case .invalidURLRequest:
        return "OM100"
      case .httpStatusCodeError(let error):
          return error.code
      case .custom:
          return "OM999"
      }
  }
  
}
