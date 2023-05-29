//
//  HondangmuError.swift
//  HongdangmuMarket
//
//  Created by minsson on 2023/05/30.
//

import Foundation

enum HongdangmuError: LocalizedError {
  
  case openMarketAPIServiceError(OpenMarketAPIError)
  case businessLogicError(BusinessLogicError)
  case customError(String)
  case unknownError
  
}

