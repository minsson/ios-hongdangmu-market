//
//  ItemListViewModel.swift
//  HongdangmuMarket
//
//  Created by minsson on 2023/04/09.
//

import Foundation

final class ItemListViewModel: ObservableObject {
  
  @Published var shouldPresentItemAddView: Bool = false
  @Published var shouldPresentRecentlyAddedItem: Bool = false
  @Published private(set) var items: [Item] = []
  
  private(set) var hasMoreData = true
  private(set) var recentlyAddedItem: String = ""
  private var currentPage = 1
  
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

private extension ItemListViewModel {
  
  func retrieveItems() async {
    do {
      let data: Data = try await requestItemListPageData(pageNumber: currentPage)
      let itemListPage = try DataToEntityConverter().convert(data: data, to: ItemListPageDTO.self)
      currentPage += 1
      
      await MainActor.run { [weak self] in
        self?.hasMoreData = itemListPage.hasNext
        self?.items.append(contentsOf: itemListPage.items)
      }
    } catch {
      print(error.localizedDescription)
    }
  }
  
  func requestItemListPageData(pageNumber: Int) async throws -> Data {
    guard let request: URLRequest = API.LookUpItems(pageNumber: pageNumber, itemsPerPage: 100, searchValue: nil).urlRequest else {
      throw URLError(.badURL)
    }
    
    let data = try await NetworkManager().execute(request)
    return data
  }
  
}
