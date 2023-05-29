//
//  ItemListViewModel.swift
//  HongdangmuMarket
//
//  Created by minsson on 2023/04/09.
//

import Foundation

final class ItemListViewModel: ObservableObject {
  
  let searchValue: String?
  @Published private(set) var items: [Item] = []
  @Published var error: HongdangmuError?
  
  private(set) var hasMoreData = true
  private var currentPage = 1
  private let openMarketAPIService = OpenMarketAPIService()
  
  init(searchValue: String? = nil) {
    self.searchValue = searchValue
  }
  
}

extension ItemListViewModel {
  
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
    do {
      let data: Data = try await openMarketAPIService.itemListPageData(pageNumber: currentPage, searchValue: searchValue ?? "")
      let itemListPage: ItemListPage = try DataToEntityConverter().convert(data: data, to: ItemListPageDTO.self)
      currentPage += 1
      
      await MainActor.run { [weak self] in
        self?.hasMoreData = itemListPage.hasNext
        self?.items.append(contentsOf: itemListPage.items)
      }
    } catch let error as OpenMarketAPIError {
      self.error = HongdangmuError.openMarketAPIServiceError(error)
    } catch let error as BusinessLogicError {
      self.error = HongdangmuError.businessLogicError(error)
    } catch {
      self.error = HongdangmuError.unknownError
    }
  }
  
}
