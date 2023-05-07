//
//  ItemListPage.swift
//  HongdangmuMarket
//
//  Created by minsson on 2023/04/09.
//

import Foundation

struct ItemListPage {
  
  let pageNumber: Int
  let itemsPerPage: Int
  let totalCount: Int
  let offset: Int
  let limit: Int
  let items: [Item]
  let lastPage: Int
  let hasNext, hasPrevious: Bool
  
  private enum CodingKeys: String, CodingKey {
    
    case pageNumber = "pageNo"
    case itemsPerPage = "itemsPerPage"
    case totalCount = "totalCount"
    case offset
    case limit
    case items = "pages"
    case lastPage = "lastPage"
    case hasNext = "hasNext"
    case hasPrevious = "hasPrev"
    
  }
  
}
