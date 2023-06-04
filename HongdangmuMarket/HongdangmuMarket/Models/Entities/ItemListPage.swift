//
//  ItemListPage.swift
//  HongdangmuMarket
//
//  Created by minsson on 2023/04/09.
//

struct ItemListPage {
  
  let pageNumber: Int
  let itemsPerPage: Int
  let totalCount: Int
  let items: [Item]
  let hasNext: Bool
  
  private enum CodingKeys: String, CodingKey {
    
    case pageNumber = "pageNo"
    case itemsPerPage = "itemsPerPage"
    case totalCount = "totalCount"
    case items = "pages"
    case hasNext = "hasNext"
    
  }
  
}
