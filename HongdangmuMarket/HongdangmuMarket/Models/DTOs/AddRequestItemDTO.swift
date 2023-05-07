//
//  PostRequestItemDTO.swift
//  HongdangmuMarket
//
//  Created by minsson on 2023/04/09.
//

import Foundation

struct AddRequestItemDTO: Encodable {
  
  let name: String?
  let price, discountedPrice: Double
  let currency: String
  let stock: Int
  let description: String
  let secret: String = "ebs12345"
  let thumbnailID: Int? = nil
  
  private enum CodingKeys: String, CodingKey {
    case name, price, currency, stock, description, secret
    case discountedPrice = "discounted_price"
    case thumbnailID = "thumbnail_id"
  }
  
}

extension AddRequestItemDTO {
  
  func toData() -> Data {
    do {
      let requestItemData = try JSONEncoder().encode(self)
      return requestItemData
    } catch {
      return Data()
    }
  }
  
}
