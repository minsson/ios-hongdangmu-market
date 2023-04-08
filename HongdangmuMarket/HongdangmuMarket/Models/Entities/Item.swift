//
//  Item.swift
//  HongdangmuMarket
//
//  Created by minsson on 2023/04/08.
//

import Foundation

struct Item {
    
    let id, vendorID: Int
    let name: String
    let thumbnail: String
    let price, bargainPrice, discountedPrice: Int
    let stock: Int
    let createdAt, issuedAt: String
    
}
