//
//  ItemSearchViewModel.swift
//  HongdangmuMarket
//
//  Created by minsson on 2023/05/20.
//

import Foundation

final class ItemSearchViewModel: ObservableObject {
  
  @Published var searchBarText: String = ""
  
  var shouldPresentTextDeletionButton: Bool {
    searchBarText.isEmpty ? false : true
  }
  
  func textDeletionButtonTapped() {
    searchBarText = ""
  }
  
}
