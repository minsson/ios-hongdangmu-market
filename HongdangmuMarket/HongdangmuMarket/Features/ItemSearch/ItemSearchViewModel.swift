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
  
  var shouldPresentTextDeletionButton: Bool {
    searchBarText.isEmpty ? false : true
  }
  
  func textDeletionButtonTapped() {
    searchBarText = ""
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

}
