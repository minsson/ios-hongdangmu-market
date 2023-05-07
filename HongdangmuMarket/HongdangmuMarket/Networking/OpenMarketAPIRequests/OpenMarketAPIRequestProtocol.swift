//
//  OpenMarketAPIRequestProtocol.swift
//  HongdangmuMarket
//
//  Created by minsson on 2023/04/09.
//

protocol OpenMarketAPIRequestProtocol {
  
  var urlHost: String { get }
  var urlPath: String { get }
  var httpMethod: String { get }
  
}

extension OpenMarketAPIRequestProtocol {
  
  var urlHost: String {
    return "https://openmarket.yagom-academy.kr"
  }
  
  var urlPath: String {
    return "/api/products/"
  }
  
}
