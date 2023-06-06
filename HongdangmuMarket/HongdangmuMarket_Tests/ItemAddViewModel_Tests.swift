//
//  ItemAddViewModel_Tests.swift
//  HongdangmuMarket_Tests
//
//  Created by minsson on 2023/06/06.
//

import XCTest
@testable import HongdangmuMarket

final class ItemAddViewModel_Tests: XCTestCase {
  
  private var sut: ItemAddViewModel!
  private var mockOpenMarketAPIService: MockOpenMarketAPIService!
  private var mockCenter: MockCenter!
  
  override func setUpWithError() throws {
    mockOpenMarketAPIService = MockOpenMarketAPIService()
    mockCenter = MockCenter()
    try super.setUpWithError()
  }
  
  override func tearDownWithError() throws {
    sut = nil
    mockOpenMarketAPIService = nil
    mockCenter = nil
    try super.tearDownWithError()
  }
  
}

extension ItemAddViewModel_Tests {
  
  // MARK: - finishButtonTapped()
  
  func test_ItemAddViewModel_finishButtonTapped_ExecutesItemAddCompletionWithoutError() async {
    // Given
    let itemAddCompletionExpectation = expectation(description: "itemAddCompletion is called")
    
    sut = ItemAddViewModel(openMarketAPIService: mockOpenMarketAPIService, itemAddCompletion: { _ in
      itemAddCompletionExpectation.fulfill()
    })
    
    // When
    sut.finishButtonTapped()
    
    // Then
    await fulfillment(of: [itemAddCompletionExpectation], timeout: 3)
    
  }
  
  func test_ItemAddViewModel_finishButtonTapped_DummyRecentlyAddedItemIDEqualsToRecentlyAddedItemID() async {
    // Given
    let itemAddCompletionExpectation = expectation(description: "itemAddCompletion is called")
    let dummyRecentlyAddedItem = mockCenter.dummyItem
    var recentlyAddedItemID: String = ""
    
    sut = ItemAddViewModel(openMarketAPIService: mockOpenMarketAPIService, itemAddCompletion: { addedItemID in
      recentlyAddedItemID = addedItemID
      itemAddCompletionExpectation.fulfill()
    })
    
    // When
    sut.finishButtonTapped()
    
    // Then
    await fulfillment(of: [itemAddCompletionExpectation], timeout: 3)
    XCTAssertEqual(dummyRecentlyAddedItem.id, recentlyAddedItemID)
  }
  
}
