//
//  MySalesHistoryContainerViewModel_Tests.swift
//  HongdangmuMarket_Tests
//
//  Created by minsson on 2023/06/07.
//

import XCTest
@testable import HongdangmuMarket

final class MySalesHistoryContainerViewModel_Tests: XCTestCase {
  
  private var sut: MySalesHistoryContainerViewModel!
  private var mockOpenMarketAPIService: MockOpenMarketAPIService!
  private var mockCenter: MockCenter!
  
  override func setUpWithError() throws {
    try super.setUpWithError()
    mockOpenMarketAPIService = MockOpenMarketAPIService()
    mockCenter = MockCenter()
    sut = MySalesHistoryContainerViewModel(openMarketAPIService: mockOpenMarketAPIService)
  }
  
  override func tearDownWithError() throws {
    mockOpenMarketAPIService = nil
    mockCenter = nil
    sut = nil
    try super.tearDownWithError()
  }
  
}

extension MySalesHistoryContainerViewModel_Tests {
  
  func test_MySalesHistoryContainerViewModel_viewNeedsMoreContents_RetrievesItems() {
    // Given
    let expectation = self.expectation(description: "Items were retrieved")
    
    // When
    Task {
      await self.sut.viewNeedsMoreContents()
      expectation.fulfill()
    }
    
    // Then
    waitForExpectations(timeout: 5) { [weak self] error in
      if let error = error {
        XCTFail("waitForExpectations failed: \(error)")
      }
      XCTAssertTrue(self?.sut.items.count ?? 0 > 0)
    }
  }
  
  func test_MySalesHistoryContainerViewModel_itemDeletionCompletionExecuted_RemovesItemFromItems() {
    // Given
    let deletedItemID = "1"
    
    // When
    sut.itemDeletionCompletionExecuted(deletedItemID: deletedItemID)
    
    // Then
    XCTAssertFalse(sut.items.contains { $0.id == deletedItemID })
  }
  
}
