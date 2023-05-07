//
//  API+LookUpItemDetail.swift
//  HongdangmuMarket
//
//  Created by minsson on 2023/04/09.
//

extension API {
  
  struct LookUpItemDetail: OpenMarketAPIRequestGetProtocol {
    
    var itemID: String?
    var queryItems: [String: String?]? = nil
    
    init(productID: String) {
      self.itemID = productID
    }
    
  }
  
}
