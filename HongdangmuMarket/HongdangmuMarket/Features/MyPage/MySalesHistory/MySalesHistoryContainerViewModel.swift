//
//  MySalesHistoryContainerViewModel.swift
//  HongdangmuMarket
//
//  Created by minsson on 2023/04/15.
//

import Foundation

final class MySalesHistoryContainerViewModel: ObservableObject, ViewModelErrorHandlingProtocol {
  
  @Published var shouldPresentItemAddView: Bool = false
  @Published var error: HongdangmuError?
  @Published private(set) var items: [Item] = []
  
  private let openMarketAPIService: OpenMarketAPIServiceProtocol
  private var currentPage = 1
  private(set) var hasMoreData = false
  
  init(openMarketAPIService: OpenMarketAPIServiceProtocol = OpenMarketAPIService()) {
    self.openMarketAPIService = openMarketAPIService
  }
  
}

extension MySalesHistoryContainerViewModel {
  
  var onSalesItems: [Item] {
    return items.filter { $0.stock > 0 }
  }
  
  var soldOutItems: [Item] {
    return items.filter { $0.stock == 0 }
  }
  
  func viewNeedsMoreContents() async {
    await self.handleError {
      try await retrieveItems()
    }
  }
  
  func sellingCompletedButtonTapped(item: Item) {
    Task { [weak self] in
      await self?.handleError {
        var updatedItem = item
        updatedItem.stock = 0
        try await self?.openMarketAPIService.update(stock: 0, of: updatedItem)
      }
    }
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

private extension MySalesHistoryContainerViewModel {
  
  func retrieveItems() async throws {
    let data: Data = try await requestItemListPageData(pageNumber: currentPage)
    guard let itemListPage = try? DataToEntityConverter().convert(data: data, to: ItemListPageDTO.self) else {
      return
    }
    
    currentPage += 1
    
    await MainActor.run { [weak self] in
      self?.hasMoreData = itemListPage.hasNext
      self?.items.append(contentsOf: itemListPage.items)
    }
  }
  
  func requestItemListPageData(pageNumber: Int) async throws -> Data {
    guard let request: URLRequest = API.LookUpItems(pageNumber: pageNumber, itemsPerPage: 100, searchValue: LoginData.shared.nickname).urlRequest else {
      throw HongdangmuError.openMarketAPIServiceError(.invalidURLRequest)
    }
    
    let data = try await NetworkManager().execute(request)
    return data
  }
  
}
