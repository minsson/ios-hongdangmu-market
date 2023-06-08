//
//  ItemListContainerView.swift
//  HongdangmuMarket
//
//  Created by minsson on 2023/05/24.
//

import SwiftUI

struct ItemListContainerView: View {
  
  @StateObject private var viewModel = ItemListContainerViewModel()
  @StateObject private var itemListViewModel = ItemListViewModel()
  
  var body: some View {
    VStack {
      hiddenNavigationLinkToRecentlyAddedItem(for: viewModel.recentlyAddedItem)
      
      headerBar
        .padding(.bottom, 16)
      
      ItemListView(viewModel: itemListViewModel)
    }
    .overlay(alignment: .bottomTrailing) {
      addButton
        .offset(x: -30, y: -30)
    }
    .fullScreenCover(isPresented: $viewModel.shouldPresentItemAddView) {
      ItemAddView() { itemID in
        Task {
          await viewModel.itemAddActionFinished(addedItemID: itemID)
          await itemListViewModel.itemListRefreshed()
        }
      }
    }
  }
  
}

private extension ItemListContainerView {
  
  func hiddenNavigationLinkToRecentlyAddedItem(for itemID: String) -> some View {
    NavigationLink(isActive: $viewModel.shouldPresentRecentlyAddedItem) {
      ItemDetailView(itemID: itemID) {
        itemListViewModel.itemDeletionCompletionExecuted(deletedItemID: itemID)
      }
    } label: {
      EmptyView()
    }
  }
  
  var headerBar: some View {
    VStack {
      searchButton
      
      Divider()
    }
  }
  
  var searchButton: some View {
    NavigationLink {
      ItemSearchView()
    } label: {
      Image(systemName: "magnifyingglass")
        .font(.title2)
        .foregroundColor(Color(UIColor.darkGray))
        .frame(maxWidth: .infinity, alignment: .trailing)
        .padding(.vertical, 4)
        .padding(.horizontal)
    }
  }
  
  var addButton: some View {
    Button {
      viewModel.addButtonTapped()
    } label: {
      Image(systemName: "plus")
        .font(.title2)
        .foregroundColor(.white)
        .background {
          Circle()
            .fill(Color.orange)
            .frame(width: 55, height: 55)
            .shadow(radius: 5)
        }
    }
  }
  
}

struct ItemListContainerView_Previews: PreviewProvider {
  
  static var previews: some View {
    ItemListContainerView()
  }
  
}
