//
//  ItemDetailViewModel_Tests.swift
//  HongdangmuMarket_Tests
//
//  Created by minsson on 2023/06/06.
//

import XCTest
@testable import HongdangmuMarket

final class ItemDetailViewModel_Tests: XCTestCase {
  
  private var sut: ItemDetailViewModel!
  private var mockOpenMarketAPIService: MockOpenMarketAPIService!
  private var mockLoginData = MockLoginData.shared
  private var mockCenter: MockCenter!
  
  override func setUpWithError() throws {
    try super.setUpWithError()
    mockOpenMarketAPIService = MockOpenMarketAPIService()
    mockCenter = MockCenter()
    sut = ItemDetailViewModel(itemID: mockCenter.dummyItem.id, openMarketAPIService: mockOpenMarketAPIService, itemDeletionCompletion: { })
    mockLoginData.save(nickname: "vendorName", password: "password", identifier: "identifier")
  }
  
  override func tearDownWithError() throws {
    sut = nil
    mockOpenMarketAPIService = nil
    mockLoginData.reset()
    mockCenter = nil
    try super.tearDownWithError()
  }
  
}

extension ItemDetailViewModel_Tests {
  
  // MARK: - viewOnAppearTask()
  
  func test_ItemDetailViewModel_viewOnAppearTask_retrievesItemFromAPI() async throws {
    // Given
    let expectedItem = mockCenter.dummyItem
    
    // When
    await sut.viewOnAppearTask()
    
    // Then
    XCTAssertEqual(sut.item.id, expectedItem.id)
  }
  
  // MARK: - deleteButtonTapped()
  
  func test_ItemDetailViewModel_deleteButtonTapped_DeletioniCompletionIsExecutedWithoutError() async throws {
    // Given
    let deletionCompletionExpectation = expectation(description: "deletionCompletion is called")
    mockOpenMarketAPIService = MockOpenMarketAPIService()
    
    sut = ItemDetailViewModel(itemID: "1", openMarketAPIService: mockOpenMarketAPIService, itemDeletionCompletion: {
      deletionCompletionExpectation.fulfill()
    })
    
    // When
    sut.deleteButtonTapped()
    
    // Then
    await fulfillment(of: [deletionCompletionExpectation], timeout: 3)
    XCTAssertNil(sut.error)
  }
  
  // MARK: - moreActionButtonTapped()
  
  func test_ItemDetailViewModel_moreActionButtonTapped_shouldPresentConfirmationDialogEqualsToTrue() {
    // When
    sut.moreActionButtonTapped()
    
    // Then
    XCTAssertTrue(sut.shouldPresentConfirmationDialog)
  }
  
  // MARK: - moreActionButtonTapped()
  
  func test_ItemDetailViewModel_checkItemOwner_returnsTrue_WhenItemsVendorNameEqualsToLoginDataNickname() async {
    // Given
    let loginDataNickName = mockLoginData.nickname
    sut = ItemDetailViewModel(itemID: "1", loginData: mockLoginData, openMarketAPIService: mockOpenMarketAPIService, itemDeletionCompletion: { })

    // When
    await sut.viewOnAppearTask()
    let dummyItemOwner = sut.item.vendors.name
    
    // Then
    XCTAssertEqual(dummyItemOwner, loginDataNickName)
    XCTAssertEqual(sut.checkItemOwner(), .myItem)
  }

}
