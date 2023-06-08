//
//  ItemListViewModel.swift
//  HongdangmuMarket
//
//  Created by minsson on 2023/04/09.
//

import Foundation

final class ItemListViewModel: ObservableObject, ViewModelErrorHandlingProtocol {
  
  @Published var error: HongdangmuError?
  @Published private(set) var items: [Item] = []
  @Published private(set) var isLoading = true
  
  private let searchValue: String?
  private let openMarketAPIService: OpenMarketAPIServiceProtocol
  private var hasMoreData = true
  private var currentPage = 1
  
  init(searchValue: String? = nil, openMarketAPIService: OpenMarketAPIServiceProtocol = OpenMarketAPIService()) {
    self.searchValue = searchValue
    self.openMarketAPIService = openMarketAPIService
  }
  
}

extension ItemListViewModel {
  
  var isItemsEmpty: Bool {
    return items.isEmpty
  }
  
  var searchKeyword: String {
    return searchValue ?? ""
  }
  
  func itemListRefreshed() async {
    await MainActor.run { [weak self] in
      self?.items.removeAll()
    }
    currentPage = 1
    await retrieveItems()
  }
  
  func itemListNeedsMoreContents() async {
    await retrieveItems()
  }
  
  func itemDeletionCompletionExecuted(deletedItemID: String) {
    guard let deletionIndex = items.firstIndex(where: { $0.id == deletedItemID }) else {
      return
    }
    
    Task {
      await MainActor.run { [weak self] in
        self?.items.remove(at: deletionIndex)
      }
    }
  }
  
}

private extension ItemListViewModel {
  
  func retrieveItems() async {
    await handleError {
      await switchIsLoading(true)
      
      guard let itemListPage: ItemListPage = try? await openMarketAPIService.itemListPage(pageNumber: currentPage, searchValue: searchValue ?? "") else {
        await switchIsLoading(false)
        return
      }
      
      currentPage += 1
      
      await MainActor.run { [weak self] in
        self?.hasMoreData = itemListPage.hasNext
        self?.items.append(contentsOf: itemListPage.items)
      }
      
      await switchIsLoading(false)
    }
  }
  
  func switchIsLoading(_ value: Bool) async {
    await MainActor.run { [weak self] in
      self?.isLoading = value
    }
  }
  
}
