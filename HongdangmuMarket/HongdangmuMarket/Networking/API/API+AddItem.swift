//
//  API+AddItem.swift
//  HongdangmuMarket
//
//  Created by minsson on 2023/04/09.
//

import SwiftUI

extension API {
  
  struct AddItem: OpenMarketAPIRequestPostProtocol {
    
    var jsonData: Data?
    var images: [UIImage]
    
    let boundary: String = UUID().uuidString
    let httpMethod: String = HTTPMethod.post.rawValue
    
  }
  
}
