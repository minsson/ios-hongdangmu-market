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
                ForEach(viewModel.items, id: \.id) { item in
                    NavigationLink {
                        ItemDetailView(item: item)
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
                        do {
                            try await viewModel.viewNeedsMoreContents()
                        } catch {
                            // TODO: Alert 구현
                            print(error.localizedDescription)
                        }
                    }
            }
        }
        .padding(.horizontal)
        .fullScreenCover(isPresented: $viewModel.shouldPresentItemAddView) {
            ItemAddView(shouldPresentItemAddView: $viewModel.shouldPresentItemAddView)
        }
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
    
}

struct MyOnSalesItemsView_Previews: PreviewProvider {
    
    static var previews: some View {
        MyOnSalesItemsView(viewModel: MySalesHistoryContainerViewModel(userInformation: UserInformation()))
    }
    
}
