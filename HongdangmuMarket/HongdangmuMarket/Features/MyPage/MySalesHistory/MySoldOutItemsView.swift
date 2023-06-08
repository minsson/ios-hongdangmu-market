//
//  MySoldOutItemsView.swift
//  HongdangmuMarket
//
//  Created by minsson on 2023/04/21.
//

import SwiftUI

struct MySoldOutItemsView: View {
  
  @ObservedObject var viewModel: MySalesHistoryContainerViewModel
  
  var body: some View {
    ScrollView {
      LazyVStack(spacing: 16) {
        ForEach(viewModel.soldOutItems, id: \.id) { item in
          NavigationLink {
            ItemDetailView(itemID: item.id) {
              
            }
          } label: {
            VStack(spacing: 0) {
              ItemRow(item: item, isEditable: false)
                .foregroundColor(.primary)
                .padding(.bottom, 16)
                .padding(.horizontal)
              
              Divider()
              
              Button("후기 보내기") {
                
              }
              .font(.subheadline.bold())
              .foregroundColor(.orange)
              .frame(height: 50)
              
              Rectangle()
                .fill(Color(UIColor.secondarySystemBackground))
                .frame(height: 8)
            }
          }
        }
        
        endSymbol
          .task {
            await viewModel.viewNeedsMoreContents()
          }
      }
    }
    .errorAlert(error: $viewModel.error)
  }
  
}

private extension MySoldOutItemsView {
  
  @ViewBuilder
  var endSymbol: some View {
    if viewModel.hasMoreData {
      ProgressView()
    } else {
      Text("더 많은 상품을 등록해보세요 🥕")
    }
  }
  
}

struct MySoldOutItemsView_Previews: PreviewProvider {
  
  static var previews: some View {
    MySoldOutItemsView(viewModel: MySalesHistoryContainerViewModel())
  }
  
}
