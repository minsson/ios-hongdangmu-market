//
//  Currency.swift
//  HongdangmuMarket
//
//  Created by minsson on 2023/06/08.
//

enum Currency {
  
  case krw
  
  var symbol: String {
    switch self {
    case .krw:
      return "₩"
    }
  }
  
}
