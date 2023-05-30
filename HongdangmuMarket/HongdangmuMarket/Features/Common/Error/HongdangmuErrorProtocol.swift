//
//  HongdangmuErrorProtocol.swift
//  HongdangmuMarket
//
//  Created by minsson on 2023/05/30.
//

import Foundation

protocol HongdangmuErrorProtocol: LocalizedError {
  
  var code: String { get }
  
}

extension HongdangmuErrorProtocol {
  
  var errorDescription: String? {
      switch self {
      default:
          return "에러가 발생했어요 😿"
      }
  }
  
  var recoverySuggestion: String? {
      switch self {
      default:
          return "다시 해봐도 안 되면 개발자에게 에러 코드를 말씀해주세요. 빠르게 해결해드릴게요! \n" + "(에러코드: \(code))"
      }
  }
  
}
