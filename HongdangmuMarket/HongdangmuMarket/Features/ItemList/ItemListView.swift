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
            headerView
                .padding(.bottom, 16)
            
            ScrollView {
                LazyVStack(spacing: 16) {
                    ForEach(viewModel.items, id: \.id) { item in
                        NavigationLink {
                            ItemDetailView(item: item)
                        } label: {
                            VStack(spacing: 16) {
                                ItemRowView(item: item)
                                    .foregroundColor(.primary)
                                    .task {
                                        guard let currentPageItems = viewModel.itemListPageData?.items else {
                                            return
                                        }
                                        
                                        if viewModel.itemListPageData?.hasNext == true,
                                           item.id == currentPageItems[currentPageItems.count - 5].id {
                                            
                                            try? await viewModel.listScrollIsAlmostOver()
                                        }
                                    }
                                Divider()
                            }
                        }
                    }
                }
            }
            .padding(.horizontal)
            .overlay(alignment: .bottomTrailing) {
                addButton
                    .offset(x: -30, y: -30)
            }
        }
        .task {
            Task {
                do {
                    try await viewModel.viewWillAppear()
                } catch {
                    // TODO: Alert 구현
                    print(error.localizedDescription)
                }
            }
        }
        .fullScreenCover(isPresented: $viewModel.shouldPresentItemAddView) {
            ItemAddView(shouldPresentItemAddView: $viewModel.shouldPresentItemAddView)
        }
    }
    
}

private extension ItemListView {
    
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
    
}

struct ItemListView_Previews: PreviewProvider {
    
    static var previews: some View {
        ItemListView()
    }
    
}
