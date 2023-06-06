//
//  ItemAddViewModel.swift
//  HongdangmuMarket
//
//  Created by minsson on 2023/04/09.
//

import SwiftUI

final class ItemAddViewModel: ObservableObject, ItemAddEditViewModelProtocol, ViewModelErrorHandlingProtocol {
  
  @Published var shouldPresentImagePicker: Bool = false
  @Published var error: HongdangmuError?
  
  @Published var selectedImages: [UIImage] = []
  @Published var title: String = ""
  @Published var price: String = ""
  @Published var description: String = ""
  
  private let itemAddCompletion: ((String) -> ())?
  private let openMarketAPIService = OpenMarketAPIService()
  
  init(itemAddCompletion: ((String) -> ())?) {
    self.itemAddCompletion = itemAddCompletion
  }
  
  func finishButtonTapped() {
    Task { [weak self] in
      await self?.handleError { [weak self] in
        try await self?.requestToAddItem()
        try await self?.retrieveRecentlyAddedItemID()
      }
    }
  }
  
}

private extension ItemAddViewModel {
  
  func requestToAddItem() async throws {
    let itemData = processInputToData()
    try await openMarketAPIService.addItem(data: itemData, images: selectedImages)
  }
  
  func retrieveRecentlyAddedItemID() async throws {
    let recentlyAddedItem: Item = try await openMarketAPIService.retrieveRecentlyAddedItem()
    
    itemAddCompletion?(recentlyAddedItem.id)
  }
  
}
