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
