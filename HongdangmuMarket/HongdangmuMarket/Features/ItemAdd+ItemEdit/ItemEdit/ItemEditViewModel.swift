//
//  ItemEditViewModel.swift
//  HongdangmuMarket
//
//  Created by minsson on 2023/05/13.
//

import UIKit.UIImage

final class ItemEditViewModel: ObservableObject, ItemAddEditViewModelProtocol {
  
  @Published var shouldPresentImagePicker: Bool = false
  @Published var error: HongdangmuError?
  
  @Published var selectedImages: [ItemDetailImage]
  @Published var title: String = ""
  @Published var price: String = ""
  @Published var description: String = ""
  
  let item: Item
  let itemEditCompletion: () -> ()
  
  private let openMarketAPIService = OpenMarketAPIService()
  
  init(item: Item, selectedImages: [ItemDetailImage], itemEditCompletion: @escaping () -> ()) {
    self.item = item
    self.selectedImages = selectedImages
    self.itemEditCompletion = itemEditCompletion
    
    title = item.name
    price = String(item.price)
    description = item.description
  }
  
  func finishButtonTapped() {
    Task { [weak self] in
      do {
        try await self?.editItem()
      } catch let error as OpenMarketAPIError {
        self?.error = HongdangmuError.openMarketAPIServiceError(error)
      } catch {
        self?.error = HongdangmuError.unknownError
      }
    }
  }
  
}

private extension ItemEditViewModel {
  
  func editItem() async throws {
    let data = processInputToData()
    try await openMarketAPIService.editItem(id: item.id, with: data)
    
    itemEditCompletion()
  }
  
}
