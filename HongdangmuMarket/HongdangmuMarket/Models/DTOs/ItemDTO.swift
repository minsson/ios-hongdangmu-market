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
    let thumbnail: String
    let price, bargainPrice, discountedPrice: Double
    let stock: Int
    let createdAt, issuedAt: String
    
    private enum CodingKeys: String, CodingKey {
        case id
        case vendorID = "vendor_id"
        case name, thumbnail, price
        case bargainPrice = "bargain_price"
        case discountedPrice = "discounted_price"
        case stock
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
            thumbnail: thumbnail,
            price: Int(price.rounded(.towardZero)),
            bargainPrice: Int(bargainPrice.rounded(.towardZero)),
            discountedPrice: Int(discountedPrice.rounded(.towardZero)),
            stock: stock,
            createdAt: createdAt,
            issuedAt: issuedAt
        )
    }
    
}
