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
  
  private var isRecentSearchWordTapped: Bool = false
  private let openMarketAPIService = OpenMarketAPIService()
  
  var hasSearchBarText: Bool {
    searchBarText.isEmpty ? false : true
  }
  
  func textDeletionButtonTapped() {
    searchBarText = ""
    
    switchPresentedView(by: .recentSearchWords)
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
    
    switchPresentedView(by: .listBySearchValue)
  }
  
  func searchBarTextWasChanged() {
    if searchBarText == "" {
      switchPresentedView(by: .recentSearchWords)
      return
    }
    
    if isRecentSearchWordTapped {
      switchPresentedView(by: .listBySearchValue)
      isRecentSearchWordTapped = false
      return
    }
    
    switchPresentedView(by: .suggestionWords)
    
    Task {
      await MainActor.run { [weak self] in
        self?.suggestionWords.removeAll()
      }
      
      await retrieveSuggestionWords(for: searchBarText)
    }
  }
  
  func recentSearchWordTapped(word: String) {
    searchBarText = word
    isRecentSearchWordTapped = true
    updateRecentWordsOrder(of: word)
  }
  
  func suggestionWordTapped() {
    switchPresentedView(by: .listBySearchValue)
  }
  
}

private extension ItemSearchViewModel {
  
  func retrieveSuggestionWords(for text: String) async {
    let data = await openMarketAPIService.suggestionWords(for: text)
    
    guard let words = try? JSONDecoder().decode([String].self, from: data) else {
      return
    }
    
    await MainActor.run {
      suggestionWords = words
    }
  }
  
  func switchPresentedView(by searchPhase: SearchPhase) {
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
