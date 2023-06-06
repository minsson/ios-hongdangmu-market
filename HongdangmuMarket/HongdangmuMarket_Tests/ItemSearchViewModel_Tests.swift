//
//  ItemSearchViewModel_Tests.swift
//  HongdangmuMarket_Tests
//
//  Created by minsson on 2023/06/07.
//

import XCTest
@testable import HongdangmuMarket

final class ItemSearchViewModel_Tests: XCTestCase {
  
  var sut: ItemSearchViewModel!
  
  override func setUpWithError() throws {
    try super.setUpWithError()
    sut = ItemSearchViewModel(openMarketAPIService: MockOpenMarketAPIService())
    
  }
  
  override func tearDownWithError() throws {
    sut = nil
    try super.tearDownWithError()
  }
  
}

extension ItemSearchViewModel_Tests {
  
  // MARK: - deleteRecentSearchWordsButtonTapped()
  
  func test_ItemSearchViewModel_deleteRecentSearchWordsButtonTapped_RemovesAllRecentSearchWords() {
    // Given
    
    // When
    sut.deleteRecentSearchWordsButtonTapped()
    
    // Then
    XCTAssertTrue(sut.recentSearchWords.isEmpty)
  }
  
  func test_ItemSearchViewModel_deleteOneSearchWordButtonTapped_RemovesWordFromRecentSearchWords() {
    // Given
    let wordToRemove = "Temp 1"
    
    // When
    sut.deleteOneSearchWordButtonTapped(wordToRemove)
    
    // Then
    XCTAssertFalse(sut.recentSearchWords.contains(wordToRemove))
  }
  
  // MARK: - searchWordWasSubmitted()
  
  func test_ItemSearchViewModel_searchWordWasSubmitted_AddsWordToRecentSearchWords() {
    // Given
    let wordToSubmit = "New Word"
    
    // When
    sut.searchWordWasSubmitted(wordToSubmit)
    
    // Then
    XCTAssertTrue(sut.recentSearchWords.first == wordToSubmit)
  }
  
  // MARK: - recentSearchWordTapped()
  
  func test_ItemSearchViewModel_recentSearchWordTapped_SetsSearchBarTextToTappedWord() {
    // Given
    let wordToTap = "Temp 1"
    
    // When
    sut.recentSearchWordTapped(word: wordToTap)
    
    // Then
    XCTAssertTrue(sut.searchBarText == wordToTap)
  }
  
  // MARK: - searchBarTextWasChanged()
  
  func test_ItemSearchViewModel_searchBarTextWasChanged_EmptyString_UpdatesSearchPhaseToRecentSearchWords() {
    // Given
    sut.searchBarText = ""
    
    // When
    sut.searchBarTextWasChanged()
    
    // Then
    XCTAssertEqual(sut.searchPhase, .recentSearchWords)
  }
  
  func test_ItemSearchViewModel_searchBarTextWasChanged_RecentSearchWordTap_UpdatesSearchPhaseToListBySearchValue() {
    // Given
    sut.searchBarText = ""
    
    // When
    sut.recentSearchWordTapped(word: "Temp 1")
    sut.searchBarTextWasChanged()
    
    // Then
    XCTAssertEqual(sut.searchPhase, .listBySearchValue)
  }
  
  func test_ItemSearchViewModel_searchBarTextWasChanged_UpdatesSearchPhaseToSuggestionWords() {
    // Given
    sut.searchBarText = "New Word"
    
    // When
    sut.searchBarTextWasChanged()
    
    // Then
    XCTAssertEqual(sut.searchPhase, .suggestionWords)
  }
  
}



