//
//  OpenMarketAPIRequestDeleteProtocol.swift
//  HongdangmuMarket
//
//  Created by minsson on 2023/05/09.
//

import Foundation

protocol OpenMarketAPIRequestDeleteProtocol: OpenMarketAPIRequestProtocol {
  
  var itemID: String { get }
  var uriSearchHTTPMethod: String { get }
  var deletionItemURI: String { get }
  
}

extension OpenMarketAPIRequestDeleteProtocol {
  
  var uriSearchURL: URL? {
    var urlComponents = URLComponents(string: urlHost + urlPath)
    
    let itemID = itemID
    urlComponents?.path += "\(String(describing: itemID))/"
    urlComponents?.path += "archived"
    
    return urlComponents?.url
  }
  
  var uriRetrievingURLRequest: URLRequest? {
    guard let url = uriSearchURL else {
      return nil
    }
    
    var request = URLRequest(url: url)
    request.httpMethod = uriSearchHTTPMethod
    request.setValue(LoginData.shared.identifier, forHTTPHeaderField: "identifier")
    request.setValue("application/json", forHTTPHeaderField: "Content-type")
    
    let body: [String: Any] = ["secret": LoginData.shared.password]
    let bodyData: Data? = try? JSONSerialization.data(withJSONObject: body)
    
    request.httpBody = bodyData
    return request
  }
  
  var url: URL? {
    var urlComponents = URLComponents(string: urlHost)
    urlComponents?.path += deletionItemURI
    
    return urlComponents?.url
  }
  
  
  var urlRequest: URLRequest? {
    guard let url = url else {
      return nil
    }
    
    var request = URLRequest(url: url)
    request.httpMethod = httpMethod
    request.setValue(LoginData.shared.identifier, forHTTPHeaderField: "identifier")
    
    return request
  }
  
}
