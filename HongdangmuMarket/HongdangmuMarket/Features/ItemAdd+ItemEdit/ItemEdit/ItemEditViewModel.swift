//
//  ItemEditViewModel.swift
//  HongdangmuMarket
//
//  Created by minsson on 2023/05/13.
//

import UIKit.UIImage

final class ItemEditViewModel: ObservableObject, ItemAddEditViewModelProtocol, ViewModelErrorHandlingProtocol {
  
  @Published var shouldPresentImagePicker: Bool = false
  @Published var title: String = ""
  @Published var price: String = ""
  @Published var description: String = ""
  @Published var error: HongdangmuError?
  
  let item: Item

  private let itemEditCompletion: () -> ()
  private let openMarketAPIService = OpenMarketAPIService()
  
  init(item: Item, itemEditCompletion: @escaping () -> ()) {
    self.item = item
    self.itemEditCompletion = itemEditCompletion
    
    title = item.name
    price = String(item.price)
    description = item.description
  }
  
  func finishButtonTapped() {
    Task { [weak self] in
      await self?.handleError {
        try await self?.editItem()
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
