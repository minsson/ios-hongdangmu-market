//
//  Item.swift
//  HongdangmuMarket
//
//  Created by minsson on 2023/04/08.
//

import Foundation

struct Item: Hashable {
  
  let id, vendorID: String
  let name: String
  let description: String
  let thumbnail: String
  let price, bargainPrice, discountedPrice: Int
  var stock: Int
  let images: [ItemImageData]
  let vendors: Vendor
  let createdAt, issuedAt: Date
  
  private var dateDifferenceFromCreatedDate: Int {
    let dateDifferenceFromCreatedDate = DateCalculator().dateDifferenceToToday(from: createdAt)
    
    return dateDifferenceFromCreatedDate
  }
  
  private var dateDifferenceFromModifiedDate: Int {
    let dateDifferenceFromModifiedDate = DateCalculator().dateDifferenceToToday(from: issuedAt)
    
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
 
  func toDTO() -> ItemDTO {
    let dateCalculator = DateCalculator()
    let serverDateFormat = "yyyy-MM-dd'T'HH:mm:ss"
    
    return ItemDTO(
      id: Int(id) ?? 0,
      vendorID: Int(vendorID) ?? 0,
      name: name,
      description: description,
      thumbnail: thumbnail,
      price: Double(price),
      bargainPrice: Double(bargainPrice),
      discountedPrice: Double(discountedPrice),
      stock: stock,
      images: images,
      vendors: vendors,
      createdAt: dateCalculator.dateToString(createdAt, usingFormat: serverDateFormat),
      issuedAt: dateCalculator.dateToString(issuedAt, usingFormat: serverDateFormat)
    )
  }
  
}
