//
//  API+EditItem.swift
//  HongdangmuMarket
//
//  Created by minsson on 2023/05/11.
//

import Foundation

extension API {
  
  struct EditItem: OpenMarketAPIRequestPatchProtocol {
    
    var productID: String?
    var jsonData: Data?
    
    let httpMethod: String = HTTPMethod.patch.rawValue
    
    init(productID: String, with jsonData: Data?) {
      self.productID = productID
      self.jsonData = jsonData
    }
    
  }
  
}
