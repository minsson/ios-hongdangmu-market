//
//  Item.swift
//  HongdangmuMarket
//
//  Created by minsson on 2023/04/08.
//

import Foundation

struct Item: Hashable {
    
    let id, vendorID: Int
    let name: String
    let description: String
    let thumbnail: String
    let price, bargainPrice, discountedPrice: Int
    let stock: Int
    let images: [ItemImage]?
    let vendors: Vendor?
    let createdAt, issuedAt: String
    
    var dateDifferenceFromCreatedDate: Int {
        let dateCalculator = DateCalculator()
        let dateDifferenceFromCreatedDate = dateCalculator.dateDifferenceToToday(from: createdAt)
        
        return dateDifferenceFromCreatedDate
    }
    
    var dateDifferenceFromModifiedDate: Int {
        let dateCalculator = DateCalculator()
        let dateDifferenceFromModifiedDate = dateCalculator.dateDifferenceToToday(from: issuedAt)
        
        return dateDifferenceFromModifiedDate
    }
    
}
