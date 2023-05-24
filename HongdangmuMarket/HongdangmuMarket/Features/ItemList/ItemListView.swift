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
      .refreshable {
        await viewModel.itemListRefreshed()
      }
    }
  }
  
}

private extension ItemListView {
  
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
    ItemListView(viewModel: ItemListViewModel())
  }
  
}
