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
          return "빈 Data를 받았거나 파싱 로직이 맞지 않아 JSON 파싱에 실패했습니다"
      }
  }
  
}
