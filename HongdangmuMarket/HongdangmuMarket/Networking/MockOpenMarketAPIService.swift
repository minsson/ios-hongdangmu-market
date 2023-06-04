//
//  MockOpenMarketAPIService.swift
//  HongdangmuMarket
//
//  Created by minsson on 2023/06/04.
//

import UIKit.UIImage

final class MockOpenMarketAPIService: OpenMarketAPIServiceProtocol {
  
  func execute(_ request: URLRequest) async throws -> Data {
    return Data()
  }
  
  func login(nickname: String, password: String, identifier: String) {
    
  }
  
  func itemListPageData(pageNumber: Int, searchValue: String?) async throws -> Data {
    return Data()
  }
  
  func itemDetailData(itemID: String) async throws -> Data {
    return Data()
  }
  
  func deleteItem(id: String) async throws -> Data {
    return Data()
  }
  
  func addItem(data: Data, images: [UIImage]) async throws {
    
  }
  
  func retrieveRecentlyAddedItem() async throws -> Data {
    return Data()
  }
  
  func editItem(id: String, with data: Data) async throws {
    
  }
  
  func suggestionWords(for text: String) async -> Data {
    return Data()
  }
  
  func update(stock: Int, of item: Item) async throws {
    
  }
  
}
