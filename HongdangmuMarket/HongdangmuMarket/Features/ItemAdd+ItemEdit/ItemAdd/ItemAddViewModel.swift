//
//  ItemAddViewModel.swift
//  HongdangmuMarket
//
//  Created by minsson on 2023/04/09.
//

import SwiftUI

final class ItemAddViewModel: ObservableObject, ItemAddEditViewModelProtocol {
  
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
      do {
        try await self?.requestPostToServer()
        try await self?.requestRecentlyAddedItemID()
      } catch let error as OpenMarketAPIError {
        self?.error = HongdangmuError.openMarketAPIServiceError(error)
      } catch let error as BusinessLogicError {
        self?.error = HongdangmuError.businessLogicError(error)
      } catch {
        self?.error = HongdangmuError.unknownError
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
      throw HongdangmuError.openMarketAPIServiceError(.invalidDataReceived)
    }
        
    itemAddCompletion?(item.id)
  }
  
}
