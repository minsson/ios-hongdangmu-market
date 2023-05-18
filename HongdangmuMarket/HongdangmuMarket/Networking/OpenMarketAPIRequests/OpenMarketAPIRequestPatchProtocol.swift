//
//  OpenMarketAPIRequestPatchProtocol.swift
//  HongdangmuMarket
//
//  Created by minsson on 2023/05/11.
//

import Foundation

protocol OpenMarketAPIRequestPatchProtocol: OpenMarketAPIRequestProtocol {
  
  var productID: String? { get }
  var jsonData: Data? { get }
  
}

extension OpenMarketAPIRequestPatchProtocol {
  
  var url: URL? {
    
    var urlComponents = URLComponents(string: urlHost + urlPath)
    
    let productID = productID ?? ""
    urlComponents?.path += productID
    
    return urlComponents?.url
  }
  
  var urlRequest: URLRequest? {
    guard let url = url else {
      return nil
    }
    
    var request = URLRequest(url: url)
    request.httpMethod = httpMethod
    request.setValue("7184295e-4aa1-11ed-a200-354cb82ae52e", forHTTPHeaderField: "identifier")
    request.setValue("application/json", forHTTPHeaderField: "Content-type")
    request.httpBody = jsonData
    
    return request
  }
  
}
