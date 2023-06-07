//
//  ItemEditViewModel_Tests.swift
//  HongdangmuMarket_Tests
//
//  Created by minsson on 2023/06/07.
//

import XCTest
@testable import HongdangmuMarket

final class ItemEditViewModel_Tests: XCTestCase {
  
  private var sut: ItemEditViewModel!
  private var mockOpenMarketAPIService: MockOpenMarketAPIService!
  private var mockCenter: DummyData!
  private var dummyItem: Item!
  
  override func setUpWithError() throws {
    mockOpenMarketAPIService = MockOpenMarketAPIService()
    mockCenter = DummyData()
    dummyItem = mockCenter.dummyItem
    try super.setUpWithError()
  }
  
  override func tearDownWithError() throws {
    sut = nil
    mockOpenMarketAPIService = nil
    mockCenter = nil
    dummyItem = nil
    try super.tearDownWithError()
  }
    
}

extension ItemEditViewModel_Tests {
  
  // MARK: - init()
  func test_ItemEditViewModel_init_AssignsInjectedDataToPublishedProperties() {
    // Given
    
    // When
    sut = ItemEditViewModel(item: dummyItem, openMarketAPIService: mockOpenMarketAPIService, itemEditCompletion: { })
    
    // Then
    XCTAssertEqual(sut.title, dummyItem.name)
    XCTAssertEqual(sut.price, String(dummyItem.price))
    XCTAssertEqual(sut.description, dummyItem.description)
  }
  
  // MARK: - finishButtonTapped()
  
  func test_ItemEditViewModel_finishButtonTapped_ExecutesItemEditCompletionWithoutError() async {
    // Given
    let itemEditCompletionExpectation = expectation(description: "itemEditCompletion is called")
    
    sut = ItemEditViewModel(item: mockCenter.dummyItem, openMarketAPIService: mockOpenMarketAPIService, itemEditCompletion: {
      itemEditCompletionExpectation.fulfill()
    })
    
    // When
    sut.finishButtonTapped()
    
    // Then
    await fulfillment(of: [itemEditCompletionExpectation], timeout: 3)
    XCTAssertNil(sut.error)
  }
  
}
