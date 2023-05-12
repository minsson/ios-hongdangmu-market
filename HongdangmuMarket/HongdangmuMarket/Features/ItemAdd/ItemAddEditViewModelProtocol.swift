//
//  ItemAddEditViewModelProtocol.swift
//  HongdangmuMarket
//
//  Created by minsson on 2023/05/13.
//

import UIKit.UIImage

protocol ItemAddEditViewModelProtocol {
  
  var shouldPresentImagePicker: Bool { get set }
  
  var selectedImages: [UIImage] { get set }
  var title: String { get set }
  var price: String { get set }
  var description: String { get set }
  
}

extension ItemAddEditViewModelProtocol {
  
  func processInputToData() -> Data {
    let addRequestItemDTO = AddRequestItemDTO(
      name: title, //TODO: 3글자 미만 예외처리
      price: Double(price) ?? 0,
      discountedPrice: 0,
      currency: "KRW",
      stock: 1,
      description: description //TODO: 10글자 미만 예외처리
    )
    
    return addRequestItemDTO.toData()
  }
  
}
