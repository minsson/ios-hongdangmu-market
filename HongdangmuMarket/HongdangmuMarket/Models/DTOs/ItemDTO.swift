//
//  Item.swift
//  HongdangmuMarket
//
//  Created by minsson on 2023/04/08.
//

import Foundation

struct ItemDTO: DTOProtocol {
  
  typealias Entity = Item
  
  let id, vendorID: Int
  let name: String
  let description: String
  let thumbnail: String
  let price, bargainPrice, discountedPrice: Double
  let stock: Int
  let images: [ItemImage]?
  let vendors: Vendor?
  let createdAt, issuedAt: String
  
  private enum CodingKeys: String, CodingKey {
    case id
    case vendorID = "vendor_id"
    case name, thumbnail, price
    case description
    case bargainPrice = "bargain_price"
    case discountedPrice = "discounted_price"
    case stock
    case images
    case vendors
    case createdAt = "created_at"
    case issuedAt = "issued_at"
  }
  
}

extension ItemDTO {
  
  func toEntity() -> Entity {
    return Item(
      id: id,
      vendorID: vendorID,
      name: name,
      description: description,
      thumbnail: thumbnail,
      price: lroundl(price.rounded(.towardZero)),
      bargainPrice: lroundl(bargainPrice.rounded(.towardZero)),
      discountedPrice: lroundl(discountedPrice.rounded(.towardZero)),
      stock: stock,
      images: images,
      vendors: vendors,
      createdAt: createdAt,
      issuedAt: issuedAt
    )
  }
  
}
