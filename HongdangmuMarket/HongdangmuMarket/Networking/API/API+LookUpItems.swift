//
//  API+LookUpItems.swift
//  HongdangmuMarket
//
//  Created by minsson on 2023/04/09.
//

extension API {
  
  struct LookUpItems: OpenMarketAPIRequestGetProtocol {
    let pageNumber: Int
    let itemsPerPage: Int
    let searchValue: String?
    let httpMethod: HTTPMethod = .get
    
    var itemID: String?
    var queryItems: [String: String?]? {
      [
        "page_no": "\(pageNumber)",
        "items_per_page": "\(itemsPerPage)",
        "search_value": searchValue
      ]
    }
    
  }
  
}
