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
  
  private var dateDifferenceFromCreatedDate: Int {
    let dateCalculator = DateCalculator()
    let dateDifferenceFromCreatedDate = dateCalculator.dateDifferenceToToday(from: createdAt)
    
    return dateDifferenceFromCreatedDate
  }
  
  private var dateDifferenceFromModifiedDate: Int {
    let dateCalculator = DateCalculator()
    let dateDifferenceFromModifiedDate = dateCalculator.dateDifferenceToToday(from: issuedAt)
    
    return dateDifferenceFromModifiedDate
  }
  
}

extension Item {
  
  func calculatedDateString() -> String {
    if createdAt == issuedAt {
      if dateDifferenceFromCreatedDate == 0 {
        return "오늘"
      } else {
        return "\(dateDifferenceFromCreatedDate)일 전"
      }
    } else {
      if dateDifferenceFromModifiedDate == 0 {
        return "끌올 오늘"
      } else {
        return "끌올 \(dateDifferenceFromModifiedDate)일 전"
      }
    }
  }
  
}
