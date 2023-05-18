//
//  API+EditItem.swift
//  HongdangmuMarket
//
//  Created by minsson on 2023/05/11.
//

import Foundation

extension API {
  
  struct EditItem: OpenMarketAPIRequestPatchProtocol {
    
    var itemID: String?
    var jsonData: Data?
    
    let httpMethod: String = HTTPMethod.patch.rawValue
    
    init(itemID: String, with jsonData: Data?) {
      self.itemID = itemID
      self.jsonData = jsonData
    }
    
  }
  
}
