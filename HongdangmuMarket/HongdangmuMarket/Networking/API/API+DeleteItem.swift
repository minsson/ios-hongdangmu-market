//
//  API+DeleteItem.swift
//  HongdangmuMarket
//
//  Created by minsson on 2023/05/18.
//

extension API {
  
  struct DeleteItem: OpenMarketAPIRequestDeleteProtocol {
    
    var itemID: String
    var deletionTargetItemURI: String
    var httpMethodForSearchingURI = HTTPMethod.post.rawValue
    let httpMethod: String = HTTPMethod.delete.rawValue
    
  }
  
}
