//
//  OpenMarketAPIRequestDeleteProtocol.swift
//  HongdangmuMarket
//
//  Created by minsson on 2023/05/09.
//

import Foundation

protocol OpenMarketAPIRequestDeleteProtocol: OpenMarketAPIRequestProtocol {
  
  var productID: String { get }
  var httpMethodForSearchingURI: String { get }
  var deletionTargetItemURI: String { get }
  
}

extension OpenMarketAPIRequestDeleteProtocol {
  
  var urlForRetrievingURI: URL? {
    
    var urlComponents = URLComponents(string: urlHost + urlPath)
    
    let productID = productID
    urlComponents?.path += "\(String(describing: productID))/"
    urlComponents?.path += "archived"
    
    return urlComponents?.url
  }
  
  var urlRequestForRetrievingURI: URLRequest? {
    guard let url = urlForRetrievingURI else {
      return nil
    }
    
    var request = URLRequest(url: url)
    request.httpMethod = httpMethodForSearchingURI
    request.setValue("7184295e-4aa1-11ed-a200-354cb82ae52e", forHTTPHeaderField: "identifier")
    request.setValue("application/json", forHTTPHeaderField: "Content-type")
    
    let body: [String: Any] = ["secret": "ebs12345"]
    let bodyData: Data? = try? JSONSerialization.data(withJSONObject: body)
    
    request.httpBody = bodyData
    return request
  }
  
  var url: URL? {
    
    var urlComponents = URLComponents(string: urlHost)
    urlComponents?.path += deletionTargetItemURI
    
    return urlComponents?.url
  }
  
  
  var urlRequest: URLRequest? {
    guard let url = url else {
      return nil
    }
    
    var request = URLRequest(url: url)
    request.httpMethod = httpMethod
    request.setValue("7184295e-4aa1-11ed-a200-354cb82ae52e", forHTTPHeaderField: "identifier")
    
    return request
  }
  
}
