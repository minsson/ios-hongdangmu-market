//
//  HondangmuError.swift
//  HongdangmuMarket
//
//  Created by minsson on 2023/05/30.
//

import Foundation

enum HongdangmuError: HongdangmuErrorProtocol {
  
  case openMarketAPIServiceError(OpenMarketAPIError)
  case businessLogicError(BusinessLogicError)
  case customError(String)
  case unknownError
  
  var code: String {
    switch self {
    case .openMarketAPIServiceError(let error):
      return error.code
    case .businessLogicError(let error):
      return error.code
    case .customError(let errorCodeString):
      return errorCodeString
    case .unknownError:
      return "HE000"
    }
  }
  
  var failureReason: String? {
    switch self {
    case .openMarketAPIServiceError(let error):
      return error.failureReason
    case .businessLogicError(let error):
      return error.failureReason
    case .customError(let failureReasonString):
      return failureReasonString
    case .unknownError:
      return "알 수 없는 에러입니다."
    }
  }
}

