//
//  ItemSearchViewModel.swift
//  HongdangmuMarket
//
//  Created by minsson on 2023/05/20.
//

import Foundation

final class ItemSearchViewModel: ObservableObject {
  
  @Published var searchBarText: String = ""
  @Published var recentSearchWords: [String] = ["Temp  1", "Temp 2", "Temp 3", "Apple"]
  @Published var suggestionWords: [String] = []
  @Published var searchPhase: SearchPhase = .recentSearchWords
  @Published var error: HongdangmuError?
  
  private var isRecentSearchWordTapped: Bool = false
  private let openMarketAPIService = OpenMarketAPIService()
  
  var hasSearchBarText: Bool {
    searchBarText.isEmpty ? false : true
  }
  
}

extension ItemSearchViewModel {
  
  func textDeletionButtonTapped() {
    searchBarText = ""
    
    switchPresentedView(to: .recentSearchWords)
  }
  
  func deleteRecentSearchWordsButtonTapped() {
    recentSearchWords.removeAll()
  }
  
  func deleteOneSearchWordButtonTapped(_ word: String) {
    guard let index = recentSearchWords.firstIndex(where: { $0 == word }) else {
      return
    }
    
    recentSearchWords.remove(at: index)
  }
  
  func searchWordWasSubmitted(_ word: String) {
    updateRecentWordsOrder(of: word)
    
    switchPresentedView(to: .listBySearchValue)
  }
  
  func recentSearchWordTapped(word: String) {
    searchBarText = word
    isRecentSearchWordTapped = true
    updateRecentWordsOrder(of: word)
  }
  
  func suggestionWordTapped() {
    switchPresentedView(to: .listBySearchValue)
  }
  
  func searchBarTextWasChanged() {
    if searchBarText == "" {
      switchPresentedView(to: .recentSearchWords)
      return
    }
    
    if isRecentSearchWordTapped {
      switchPresentedView(to: .listBySearchValue)
      isRecentSearchWordTapped = false
      return
    }
    
    switchPresentedView(to: .suggestionWords)
    
    updateSuggestionWords()
  }
  
}

private extension ItemSearchViewModel {
  
  func updateSuggestionWords() {
    Task { [weak self] in
      await MainActor.run { [weak self] in
        self?.suggestionWords.removeAll()
      }
      
      do {
        try await self?.retrieveSuggestionWords(for: self?.searchBarText ?? "")
      } catch let error as BusinessLogicError {
        self?.error = HongdangmuError.businessLogicError(error)
      } catch {
        self?.error = HongdangmuError.unknownError
      }
    }
  }
  
  func retrieveSuggestionWords(for text: String) async throws {
    let data = await openMarketAPIService.suggestionWords(for: text)
    
    guard let words = try? JSONDecoder().decode([String].self, from: data) else {
      throw HongdangmuError.businessLogicError(.invalidParsing)
    }
    
    await MainActor.run { [weak self] in
      self?.suggestionWords = words
    }
  }
  
  func switchPresentedView(to searchPhase: SearchPhase) {
    switch searchPhase {
    case .recentSearchWords:
      self.searchPhase = .recentSearchWords
    case .suggestionWords:
      self.searchPhase = .suggestionWords
    case .listBySearchValue:
      self.searchPhase = .listBySearchValue
    }
  }
  
  func updateRecentWordsOrder(of word: String) {
    deleteOneSearchWordButtonTapped(word)
    recentSearchWords.insert(word, at: 0)
  }
  
}
