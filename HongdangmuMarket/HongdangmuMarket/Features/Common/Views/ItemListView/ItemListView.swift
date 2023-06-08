//
//  ItemListView.swift
//  HongdangmuMarket
//
//  Created by minsson on 2023/04/08.
//

import SwiftUI

struct ItemListView: View {
  
  @ObservedObject var viewModel: ItemListViewModel
  
  var body: some View {
    VStack {
      ScrollView {
        LazyVStack(spacing: 16) {
          ForEach(viewModel.items, id: \.id) { item in
            NavigationLink {
              ItemDetailView(itemID: item.id) {
                viewModel.itemDeletionCompletionExecuted(deletedItemID: item.id)
              }
            } label: {
              VStack(spacing: 16) {
                ItemRow(item: item, isEditable: false)
                  .foregroundColor(.primary)
                
                Divider()
              }
            }
          }
          
          progressView
            .padding(.vertical, 40)
            .task {
              await viewModel.itemListNeedsMoreContents()
            }
        }
      }
      .padding(.horizontal)
      .refreshable {
        await viewModel.itemListRefreshed()
      }
    }
    .errorAlert(error: $viewModel.error)
  }
  
}

private extension ItemListView {
  
  @ViewBuilder
  var progressView: some View {
    if viewModel.isLoading {
      ProgressView()
    } else if viewModel.isItemsEmpty {
      Text("앗! '\(viewModel.searchKeyword)' 검색 결과가 없어요. 🥲")
    } else {
      Text("모든 상품을 다 둘러봤어요 🙃")
    }
  }
  
}

struct ItemListView_Previews: PreviewProvider {
  
  static var previews: some View {
    ItemListView(viewModel: ItemListViewModel())
  }
  
}
