//
//  MySalesHistoryContainerViewModel.swift
//  HongdangmuMarket
//
//  Created by minsson on 2023/04/15.
//

import Foundation

final class MySalesHistoryContainerViewModel: ObservableObject {
  
  @Published var shouldPresentItemAddView: Bool = false
  @Published private(set) var items: [Item] = []
  @Published var error: HongdangmuError?
  
  private(set) var hasMoreData = false
  private let openMarketAPIService = OpenMarketAPIService()
  
  var onSalesItems: [Item] {
    return items.filter { $0.stock > 0 }
  }
  
  var soldOutItems: [Item] {
    return items.filter { $0.stock == 0 }
  }
  
  private var currentPage = 1
  
}

extension MySalesHistoryContainerViewModel {
  
  func viewNeedsMoreContents() async {
    do {
      try await retrieveItems()
    } catch let error as OpenMarketAPIError {
      self.error = HongdangmuError.openMarketAPIServiceError(error)
    } catch let error as BusinessLogicError {
      self.error = HongdangmuError.businessLogicError(error)
    } catch {
      self.error = HongdangmuError.unknownError
    }
  }
  
  func sellingCompletedButtonTapped(item: Item) {
    Task {
      do {
        var updatedItem = item
        updatedItem.stock = 0
        try await openMarketAPIService.update(stock: 0, of: updatedItem)
      } catch let error as OpenMarketAPIError {
        self.error = HongdangmuError.openMarketAPIServiceError(error)
      } catch let error as BusinessLogicError {
        self.error = HongdangmuError.businessLogicError(error)
      } catch {
        self.error = HongdangmuError.unknownError
      }
    }
  }
  
}

private extension MySalesHistoryContainerViewModel {
  
  func retrieveItems() async throws {
    let data: Data = try await requestItemListPageData(pageNumber: currentPage)
    let itemListPage = try DataToEntityConverter().convert(data: data, to: ItemListPageDTO.self)
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
