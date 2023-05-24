//
//  ItemListContainerViewModel.swift
//  HongdangmuMarket
//
//  Created by minsson on 2023/05/24.
//

import Foundation

final class ItemListContainerViewModel: ObservableObject {
  
  @Published var shouldPresentItemAddView: Bool = false
  @Published var shouldPresentRecentlyAddedItem: Bool = false
  
  private(set) var recentlyAddedItem: String = ""
  
}

extension ItemListContainerViewModel {
  
  func addButtonTapped() {
    shouldPresentItemAddView = true
  }
  
  func itemAddActionFinished(addedItemID: String) async {
    recentlyAddedItem = addedItemID
    await MainActor.run { [weak self] in
      self?.shouldPresentRecentlyAddedItem = true
    }
  }
  
}
