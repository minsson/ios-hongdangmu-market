//
//  ItemSearchViewModel.swift
//  HongdangmuMarket
//
//  Created by minsson on 2023/05/20.
//

import Foundation

final class ItemSearchViewModel: ObservableObject {
  
  @Published var searchBarText: String = ""
  @Published var recentSearchWords: [String] = ["Temp  1", "Temp 2", "Temp 3"]
  @Published var suggestionWords: [String] = []
  @Published var searchPhase: SearchPhase = .recentSearchWords

  private let openMarketAPIService = OpenMarketAPIService()

  var hasSearchBarText: Bool {
    searchBarText.isEmpty ? false : true
  }
  
  func textDeletionButtonTapped() {
    searchBarText = ""
    searchPhase = .recentSearchWords
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
    deleteOneSearchWordButtonTapped(word)
    recentSearchWords.insert(word, at: 0)
    
    searchPhase = .listBySearchValue
  }
  
  func searchBarTextWasChanged(newText: String) {
    if newText == "" {
      searchPhase = .recentSearchWords
      return
    }
    
    if newText.count - searchBarText.count != 1 {
      searchPhase = .listBySearchValue
      return
    }
     
    searchPhase = .suggestionWords
    
    Task {
      await MainActor.run { [weak self] in
        self?.suggestionWords.removeAll()
      }
      
      await retrieveSuggestionWords(for: newText)
    }
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
  
}
