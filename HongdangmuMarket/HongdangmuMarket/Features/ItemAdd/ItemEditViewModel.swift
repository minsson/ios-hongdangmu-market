//
//  ItemEditViewModel.swift
//  HongdangmuMarket
//
//  Created by minsson on 2023/05/13.
//

import UIKit.UIImage

final class ItemEditViewModel: ObservableObject, ItemAddEditViewModelProtocol {
  
  @Published var shouldPresentImagePicker: Bool = false
  
  @Published var selectedImages: [ItemDetailImage]
  @Published var title: String = ""
  @Published var price: String = ""
  @Published var description: String = ""
  
  let item: Item
  let itemEditCompletion: () -> ()
  
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
      } catch {
        print(error.localizedDescription)
      }
    }
  }
  
}

private extension ItemEditViewModel {
  
  func editItem() async throws {
    let data = processInputToData()
    guard let urlRequest = API.EditItem(productID: item.id, with: data).urlRequest else {
      return
    }
    
    let _ = try await NetworkManager().execute(urlRequest)
    itemEditCompletion()
  }
  
}
