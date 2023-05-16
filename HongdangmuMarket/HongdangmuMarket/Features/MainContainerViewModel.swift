//
//  MainContainerViewModel.swift
//  HongdangmuMarket
//
//  Created by minsson on 2023/05/16.
//

import Foundation

final class MainContainerViewModel: ObservableObject {
  
  @Published var selectedTagIndex: Int = 0
  @Published var isLoggedIn: Bool = false
  
  func loginCompletionExecuted() {
    isLoggedIn = true
  }
  
}
