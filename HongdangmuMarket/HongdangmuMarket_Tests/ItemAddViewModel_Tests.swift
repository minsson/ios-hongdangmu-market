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
  private var mockCenter: DummyData!
  
  override func setUpWithError() throws {
    mockOpenMarketAPIService = MockOpenMarketAPIService()
    mockCenter = DummyData()
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
  
  // MARK: - imageDeletionButtonTapped()
  
  func test_ItemAddViewModel_imageDeletionButtonTapped_RemovesImageFromSelectedImages() {
    // Given
    sut = ItemAddViewModel(openMarketAPIService: mockOpenMarketAPIService, itemAddCompletion: { _ in })
    let imageToDelete = UIImage(systemName: "star")!
    let images: [UIImage] = [
      UIImage(systemName: "heart")!,
      imageToDelete,
      UIImage(systemName: "diamond")!
    ]
    sut.selectedImages.append(contentsOf: images)
    
    // When
    sut.imageDeletionButtonTapped(of: imageToDelete)
    
    // Then
    XCTAssertNil(sut.selectedImages.firstIndex(of: imageToDelete))
  }
  
}
