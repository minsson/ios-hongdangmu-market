//
//  ItemAddViewModel.swift
//  HongdangmuMarket
//
//  Created by minsson on 2023/04/09.
//

import SwiftUI

final class ItemAddViewModel: ObservableObject {
  
  @Published var selectedImages: [UIImage] = []
  @Published var shouldPresentImagePicker = false
  
  @Published var title: String = ""
  @Published var price: String = ""
  @Published var description: String = ""
  
  func finishButtonTapped() {
    Task {
      await requestPostToServer()
    }
  }
  
}

private extension ItemAddViewModel {
  
  func requestPostToServer() async {
    let data = processInputToData()
    guard let urlRequest = API.AddItem(jsonData: data, images: selectedImages).urlRequest else {
      return
    }
    
    do {
      let _ = try await NetworkManager().execute(urlRequest)
    } catch {
      print(error.localizedDescription)
    }
  }
  
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
