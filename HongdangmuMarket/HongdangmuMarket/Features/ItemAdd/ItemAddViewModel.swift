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
  
  let itemAddCompletion: ((Int) -> ())?
  
  init(itemAddCompletion: ((Int) -> ())?) {
    self.itemAddCompletion = itemAddCompletion
  }
  
  func finishButtonTapped() {
    Task { [weak self] in
      await self?.requestPostToServer()
      
      do {
        try await self?.requestRecentlyAddedItemID()
      } catch {
        print(error.localizedDescription)
      }
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
  
  func requestRecentlyAddedItemID() async throws {
    guard let urlRequest = API.LookUpItems(pageNumber: 1, itemsPerPage: 1, searchValue: "sixthVendor").urlRequest else {
      throw URLError(.badURL)
    }
    
    print("🔥 아이디 기준으로 서버에 있는 첫번째 게시물 조회 시작")
    let data: Data = try await NetworkManager().execute(urlRequest)
    print("🔥 아이디 기준으로 서버에 있는 첫번째 게시물 조회 완료")
    let itemListPage = try DataToEntityConverter().convert(data: data, to: ItemListPageDTO.self)
    let items: [Item] = itemListPage.items
    guard let item = items.first else {
      throw URLError(.fileDoesNotExist)
    }
        
    itemAddCompletion?(item.id)
  }
  
}
