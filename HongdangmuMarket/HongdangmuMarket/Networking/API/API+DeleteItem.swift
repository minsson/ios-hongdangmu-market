//
//  API+DeleteItem.swift
//  HongdangmuMarket
//
//  Created by minsson on 2023/05/18.
//

extension API {
  
  struct DeleteItem: OpenMarketAPIRequestDeleteProtocol {
    
    var itemID: String
    var deletionItemURI: String
    var uriSearchHTTPMethod: HTTPMethod = .post
    let httpMethod: HTTPMethod = .delete
    
  }
  
}
