//
//  OpenMarketAPIError.swift
//  HongdangmuMarket
//
//  Created by minsson on 2023/05/30.
//

import Foundation

enum OpenMarketAPIError: LocalizedError {
  
  case httpStatusCodeError(HTTPStatusCodeError)
  case invalidURLRequest
  
}
