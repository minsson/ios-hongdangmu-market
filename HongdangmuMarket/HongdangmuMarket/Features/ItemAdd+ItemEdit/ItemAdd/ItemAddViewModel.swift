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
  
  private let openMarketAPIService = OpenMarketAPIService()
  
  init(itemAddCompletion: ((String) -> ())?) {
    self.itemAddCompletion = itemAddCompletion
  }
  
  func finishButtonTapped() {
    Task { [weak self] in
      do {
        try await self?.requestPostToServer()
        try await self?.requestRecentlyAddedItemID()
      } catch {
        print(error.localizedDescription)
      }
    }
  }
  
}

private extension ItemAddViewModel {
  
  func requestPostToServer() async throws {
    let itemData = processInputToData()
    try await openMarketAPIService.addItem(data: itemData, images: selectedImages)
  }
  
  func requestRecentlyAddedItemID() async throws {
    let data: Data = try await openMarketAPIService.retrieveRecentlyAddedItem()
    let itemListPage = try DataToEntityConverter().convert(data: data, to: ItemListPageDTO.self)
    let items: [Item] = itemListPage.items
    guard let item = items.first else {
      throw URLError(.fileDoesNotExist)
    }
        
    itemAddCompletion?(item.id)
  }
  
}
