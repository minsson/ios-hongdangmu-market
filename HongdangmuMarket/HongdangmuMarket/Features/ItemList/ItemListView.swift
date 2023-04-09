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
        NavigationView {
            VStack {
                headerView
                    .padding(.bottom, 16)
                
                ScrollView {
                    LazyVStack {
                        ForEach(viewModel.itemListPageData?.items ?? [], id: \.id) { item in
                            NavigationLink {
                                ItemDetailView(item: item)
                            } label: {
                                ItemRowView(item: item)
                                    .foregroundColor(.primary)
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
            // TODO: 기능 구현
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
