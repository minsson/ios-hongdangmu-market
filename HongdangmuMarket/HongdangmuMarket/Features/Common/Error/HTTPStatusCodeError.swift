//
//  HTTPStatusCodeError.swift
//  HongdangmuMarket
//
//  Created by minsson on 2023/05/29.
//

import Foundation

enum HTTPStatusCodeError: HongdangmuErrorProtocol {
  
  case informational
  case redirection
  case clientError(code: Int)
  case serverError(code: Int)
  case unknown(code: Int?)
  
  var code: String {
    switch self {
    case .informational:
      return "SL100"
    case .redirection:
      return "SL300"
    case .clientError(let code):
      return String(code)
    case .serverError(let code):
      return String(code)
    case .unknown(_):
      return "SL900"
    }
  }
  
  var failureReason: String? {
    switch self {
    case .informational:
      return "정보 응답 (100번대)"
    case .redirection:
      return "리다이렉션 메시지 (300번대)"
    case .clientError(let code):
      return "클라이언트 에러 (400번대 - httpStatusCode: \(code))"
    case .serverError(let code):
      return "서버 에러 (500번대 - httpStatusCode: \(code))"
    case .unknown(code: let code):
      return "알 수 없는 에러 (httpStatusCode: \(code ?? 0)"
    }
  }
  
}
