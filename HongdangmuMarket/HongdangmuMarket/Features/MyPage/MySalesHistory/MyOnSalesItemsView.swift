//
//  MyOnSalesItemsView.swift
//  HongdangmuMarket
//
//  Created by minsson on 2023/04/15.
//

import SwiftUI

struct MyOnSalesItemsView: View {
  
  @ObservedObject var viewModel: MySalesHistoryContainerViewModel
  
  var body: some View {
    ScrollView {
      LazyVStack(spacing: 16) {
        ForEach(viewModel.onSalesItems, id: \.id) { item in
          NavigationLink {
            ItemDetailView(itemID: item.id) {
              viewModel.itemDeletionCompletionExecuted(deletedItemID: item.id)
            }
          } label: {
            VStack(spacing: 0) {
              ItemRow(item: item, isEditable: false)
                .foregroundColor(.primary)
                .padding(.bottom, 16)
                .padding(.horizontal)
              
              Divider()
              
              actionButtons(with: item)
                .frame(height: 50)
              
              Rectangle()
                .fill(Color(UIColor.secondarySystemBackground))
                .frame(height: 8)
            }
          }
        }
        
        progressView
          .task {
            await viewModel.viewNeedsMoreContents()
          }
      }
    }
    .errorAlert(error: $viewModel.error)
  }
  
}

private extension MyOnSalesItemsView {
  
  @ViewBuilder
  var progressView: some View {
    if viewModel.hasMoreData {
      ProgressView()
    } else {
      Text("더 많은 상품을 등록해보세요 🥕")
    }
  }
  
  @ViewBuilder
  func actionButtons(with item: Item) -> some View {
    HStack(spacing: 0) {
      Button("끌어올리기") {
        // TODO: 기능 구현
      }
      .frame(maxWidth: .infinity)
      
      Divider()
      
      Button("예약중") {
        // TODO: 기능 구현
      }
      .frame(maxWidth: .infinity)
      
      Divider()
      
      Button("거래완료") {
        viewModel.sellingCompletedButtonTapped(item: item)
      }
      .frame(maxWidth: .infinity)
    }
    .foregroundColor(.primary)
    .font(.body.bold())
  }
  
}

struct MyOnSalesItemsView_Previews: PreviewProvider {
  
  static var previews: some View {
    MyOnSalesItemsView(viewModel: MySalesHistoryContainerViewModel())
  }
  
}
