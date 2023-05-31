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
  
  var failureReason: String? {
    switch self {
    case .invalidURLRequest:
      return "URL Request가 유효하지 않습니다."
    case .invalidDataReceived:
      return "서버로부터 유효하지 않은 데이터를 받아왔습니다."
    case .httpStatusCodeError(let httpStatusCodeError):
      return "서버로부터 \(httpStatusCodeError) 응답을 받았습니다."
    case .customError(let failureReason):
      return failureReason
    }
  }
  
}
