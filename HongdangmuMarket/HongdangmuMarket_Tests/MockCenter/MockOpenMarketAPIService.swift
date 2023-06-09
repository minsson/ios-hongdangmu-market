//
//  MockOpenMarketAPIService.swift
//  HongdangmuMarket_Tests
//
//  Created by minsson on 2023/06/06.
//

import UIKit.UIImage
@testable import HongdangmuMarket

final class MockOpenMarketAPIService: OpenMarketAPIServiceProtocol {
  
  private let mockCenter = DummyData()
  private let mockLoginData: LoginDataProtocol
  
  init(mockLoginData: LoginDataProtocol = MockLoginData.shared) {
    self.mockLoginData = mockLoginData
  }
}

extension MockOpenMarketAPIService {
  
  func login(nickname: String, password: String, identifier: String) {
    mockLoginData.save(nickname: nickname, password: password, identifier: identifier)
  }
  
  func itemListPage(pageNumber: Int, searchValue: String?) async throws -> HongdangmuMarket.ItemListPage {
    return mockCenter.dummyItemListPage
  }
  
  func itemDetail(itemID: String) async throws -> HongdangmuMarket.Item {
    return mockCenter.dummyItem
  }
  
  func deleteItem(id: String) async throws {
    return
  }
  
  func addItem(data: Data, images: [UIImage]) async throws {
    return
  }
  
  func retrieveRecentlyAddedItem() async throws -> HongdangmuMarket.Item {
    return mockCenter.dummyItem
  }
  
  func editItem(id: String, with data: Data) async throws {
    return
  }
  
  func suggestionWords(for text: String) async -> [String] {
    return []
  }
  
  func update(stock: Int, of item: HongdangmuMarket.Item) async throws {
    return
  }
  
}
