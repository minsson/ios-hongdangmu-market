//
//  MainContainerView.swift
//  HongdangmuMarket
//
//  Created by minsson on 2023/04/08.
//

import SwiftUI

struct MainContainerView: View {
  
  @StateObject private var viewModel = MainContainerViewModel()
  
  init() {
    UITabBar.appearance().backgroundColor = UIColor.white
  }
  
  var body: some View {
    if viewModel.isLoggedIn {
      NavigationView {
        TabView(selection: $viewModel.selectedTagIndex) {
          ItemListContainerView()
            .tabItem {
              Label("홈", systemImage: "house")
            }
            .tag(0)
          
          MyPageView()
            .tabItem {
              Label("나의 홍당무", systemImage: "person")
            }
            .tag(1)
        }
        .tint(.primary)
      }
    } else {
      LoginView() {
        viewModel.loginCompletionExecuted()
      }
    }
  }
  
}

struct MainContainerView_Previews: PreviewProvider {
  
  static var previews: some View {
    MainContainerView()
  }
  
}
