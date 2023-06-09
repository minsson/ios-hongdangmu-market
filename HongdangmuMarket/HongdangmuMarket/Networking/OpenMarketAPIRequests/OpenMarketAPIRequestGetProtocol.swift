//
//  OpenMarketAPIRequestGetProtocol.swift
//  HongdangmuMarket
//
//  Created by minsson on 2023/04/09.
//

import Foundation

protocol OpenMarketAPIRequestGetProtocol: OpenMarketAPIRequestProtocol {
  
  var queryItems: [String: String?]? { get }
  var itemID: String? { get }
  
}

extension OpenMarketAPIRequestGetProtocol {
  
  var url: URL? {
    var urlComponents = URLComponents(string: urlHost + urlPath)
    
    let queryItems = queryItems ?? [:]
    urlComponents?.queryItems = queryItems.map {
      URLQueryItem(name: $0.key, value: $0.value)
    }
    
    let itemID = itemID ?? ""
    urlComponents?.path += itemID
    
    return urlComponents?.url
  }
  
  var urlRequest: URLRequest? {
    guard let url else {
      return nil
    }
    let request = URLRequest(url: url)
    
    return request
  }
  
}
