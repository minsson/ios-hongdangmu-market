//
//  ItemListViewModel_Tests.swift
//  HongdangmuMarket_Tests
//
//  Created by minsson on 2023/06/06.
//

import XCTest
@testable import HongdangmuMarket

final class ItemListViewModel_Tests: XCTestCase {
  
  private var sut: ItemListViewModel!
  private var mockOpenMarketAPIService: OpenMarketAPIServiceProtocol!
  private var mockCenter: MockCenter!
  
  override func setUpWithError() throws {
    try super.setUpWithError()
    mockOpenMarketAPIService = MockOpenMarketAPIService()
    sut = ItemListViewModel(openMarketAPIService: mockOpenMarketAPIService)
    mockCenter = MockCenter()
  }
  
  override func tearDownWithError() throws {
    sut = nil
    mockOpenMarketAPIService = nil
    mockCenter = nil
    try super.tearDownWithError()
  }
  
}

extension ItemListViewModel_Tests {
  
  // MARK: - isItemsEmpty
  
  func test_isItemsEmpty_items_isEmpty() {
    // Given
    
    // When
    
    // Then
    XCTAssertEqual(sut.isItemsEmpty, sut.items.isEmpty)
  }
  
  // MARK: - searchKeyword
  
  func test_isItemsEmpty_searchKeyword_equalsToInjectedSearchValue() {
    // Given
    let injectedSearchValue = "injectedSearchValue"
    
    // When
    sut = ItemListViewModel(searchValue: injectedSearchValue, openMarketAPIService: mockOpenMarketAPIService)
    
    // Then
    XCTAssertEqual(injectedSearchValue, sut.searchKeyword)
  }
  
  // MARK: - itemListRefreshed()
  
  func test_itemListRefreshed_items_CountWillEqualToNewRetrievedItemsCount() async {
    // Given
    var itemsCountBeforeRefresh = 0
    let retrievedItemsCountPerOneExecution = mockCenter.dummyItemListPage.items.count
    let repetitionCount = 5
    
    // When
    for _ in 1...repetitionCount {
      await sut.itemListNeedsMoreContents()
      itemsCountBeforeRefresh = sut.items.count
    }
    
    await sut.itemListRefreshed()
    let itemsCountAfterRefresh = sut.items.count
    
    // Then
    XCTAssertLessThan(itemsCountAfterRefresh, itemsCountBeforeRefresh)
    XCTAssertEqual(itemsCountAfterRefresh, retrievedItemsCountPerOneExecution)
    
  }
  
  // MARK: - itemListNeedsMoreContents()
  
  func test_itemListNeedsMoreContents_items_countWillBeGreaterThanBefore() async {
    // Given
    let initialItemsCount = sut.items.count
    
    // When
    await sut.itemListNeedsMoreContents()
    
    // Then
    let currentItemsCount = sut.items.count
    XCTAssertGreaterThan(currentItemsCount, initialItemsCount)
  }
  
  func test_itemListNeedsMoreContents_items_countWillBeTwo_WhenMockCenterDummyCountIsTwo() async {
    // Given
    let dummyItemsCount = mockCenter.dummyItemListPage.items.count
    
    // When
    await sut.itemListNeedsMoreContents()
    
    // Then
    let currentItemsCount = sut.items.count
    XCTAssertEqual(currentItemsCount, dummyItemsCount)
  }
  
  // MARK: - itemDeletionCompletionExecuted(deletedItemID: String)
  
  func test_itemDeletionCompletionExecuted_items_firstItemWillBeDeleted() {
    // Given
    let dummyItems: [Item] = mockCenter.dummyItemListPage.items
    let randomIndexOfItems: Int = Int.random(in: 0..<dummyItems.count)
    let deleteTargetItem = dummyItems[randomIndexOfItems]
    
    // When
    sut.itemDeletionCompletionExecuted(deletedItemID: deleteTargetItem.id)
    let deletionTargetItem: Item? = sut.items.first { $0.id == deleteTargetItem.id }
    
    // Then
    XCTAssertNil(deletionTargetItem)
  }
  
}
