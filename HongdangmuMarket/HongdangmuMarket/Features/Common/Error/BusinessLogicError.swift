//
//  BusinessLogicError.swift
//  HongdangmuMarket
//
//  Created by minsson on 2023/05/30.
//

import Foundation

enum BusinessLogicError: HongdangmuErrorProtocol {
  
  case invalidParsing

  var code: String {
      switch self {
      case .invalidParsing:
          return "BL100"
      }
  }
  
  var failureReason: String? {
      switch self {
      case .invalidParsing:
          return "JSON 파싱 실패"
      }
  }
  
}
