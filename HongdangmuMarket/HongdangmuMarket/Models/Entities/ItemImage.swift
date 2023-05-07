//
//  ItemImage.swift
//  HongdangmuMarket
//
//  Created by minsson on 2023/04/09.
//

import Foundation

struct ItemImage: Decodable, Hashable {
  
  let id: Int
  let url: String
  let thumbnailURL: String
  let issuedAt: String
  
  private enum CodingKeys: String, CodingKey {
    
    case id
    case url
    case thumbnailURL = "thumbnail_url"
    case issuedAt = "issued_at"
    
  }
  
}
