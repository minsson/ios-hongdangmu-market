//
//  ItemAddViewModel.swift
//  HongdangmuMarket
//
//  Created by minsson on 2023/04/09.
//

import SwiftUI

final class ItemAddViewModel: ObservableObject, ItemAddEditViewModelProtocol {
  
  @Published var shouldPresentImagePicker: Bool = false
  
  @Published var selectedImages: [UIImage] = []
  @Published var title: String = ""
  @Published var price: String = ""
  @Published var description: String = ""
  
  let itemAddCompletion: ((String) -> ())?
  
  init(itemAddCompletion: ((String) -> ())?) {
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
  
  func requestRecentlyAddedItemID() async throws {
    guard let urlRequest = API.LookUpItems(pageNumber: 1, itemsPerPage: 1, searchValue: "sixthVendor").urlRequest else {
      throw URLError(.badURL)
    }
    
    let data: Data = try await NetworkManager().execute(urlRequest)
    let itemListPage = try DataToEntityConverter().convert(data: data, to: ItemListPageDTO.self)
    let items: [Item] = itemListPage.items
    guard let item = items.first else {
      throw URLError(.fileDoesNotExist)
    }
        
    itemAddCompletion?(item.id)
  }
  
}
