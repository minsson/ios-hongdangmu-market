//
//  ItemListView.swift
//  HongdangmuMarket
//
//  Created by minsson on 2023/04/08.
//

import SwiftUI

struct ItemListView: View {
  
  @StateObject private var viewModel = ItemListViewModel()
  
  var body: some View {
    VStack {
      hiddenNavigationLinkToRecentlyAddedItem(for: viewModel.recentlyAddedItem)
      
      headerView
        .padding(.bottom, 16)
      
      ScrollView {
        LazyVStack(spacing: 16) {
          ForEach(viewModel.items, id: \.id) { item in
            NavigationLink {
              ItemDetailView(itemID: item.id) {
                viewModel.itemDeletionCompletionExecuted(deletedItemID: item.id)
              }
            } label: {
              VStack(spacing: 16) {
                ItemRowView(item: item, isEditable: false)
                  .foregroundColor(.primary)
                Divider()
              }
            }
          }
          
          progressView
            .task {
              await viewModel.itemListNeedsMoreContents()
            }
        }
      }
      .padding(.horizontal)
      .overlay(alignment: .bottomTrailing) {
        addButton
          .offset(x: -30, y: -30)
      }
      .refreshable {
        await viewModel.itemListRefreshed()
      }
    }
    .fullScreenCover(isPresented: $viewModel.shouldPresentItemAddView) {
      ItemAddView() { itemID in
        Task {
          await viewModel.itemAddActionFinished(addedItemID: itemID)
          await viewModel.itemListRefreshed()
        }
      }
    }
  }
  
}

private extension ItemListView {
  
  func hiddenNavigationLinkToRecentlyAddedItem(for itemID: String) -> some View {
    NavigationLink(isActive: $viewModel.shouldPresentRecentlyAddedItem) {
      ItemDetailView(itemID: itemID) {
 
      }
    } label: {
      EmptyView()
    }
  }
  
  var headerView: some View {
    VStack {
      searchButton
      
      Divider()
    }
  }
  
  var searchButton: some View {
    Button {
      // TODO: 기능 구현
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
  
  @ViewBuilder
  var progressView: some View {
    if viewModel.hasMoreData {
      ProgressView()
    } else {
      Text("모든 상품을 다 둘러봤어요 🙃")
    }
  }
  
}

struct ItemListView_Previews: PreviewProvider {
  
  static var previews: some View {
    ItemListView()
  }
  
}
