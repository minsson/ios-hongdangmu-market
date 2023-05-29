//
//  OpenMarketAPIRequestPatchProtocol.swift
//  HongdangmuMarket
//
//  Created by minsson on 2023/05/11.
//

import Foundation

protocol OpenMarketAPIRequestPatchProtocol: OpenMarketAPIRequestProtocol {
  
  var itemID: String? { get }
  var jsonData: Data? { get }
  
}

extension OpenMarketAPIRequestPatchProtocol {
  
  var url: URL? {
    var urlComponents = URLComponents(string: urlHost + urlPath)
    
    let itemID = itemID ?? ""
    urlComponents?.path += itemID
    
    return urlComponents?.url
  }
  
  var urlRequest: URLRequest? {
    guard let url else {
      return nil
    }
    
    var request = URLRequest(url: url)
    request.httpMethod = httpMethod
    request.setValue(LoginData.shared.identifier, forHTTPHeaderField: "identifier")
    request.setValue("application/json", forHTTPHeaderField: "Content-type")
    request.httpBody = jsonData
    
    return request
  }
  
}
