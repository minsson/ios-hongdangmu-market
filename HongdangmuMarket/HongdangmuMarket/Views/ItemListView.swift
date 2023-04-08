//
//  ItemListView.swift
//  HongdangmuMarket
//
//  Created by minsson on 2023/04/08.
//

import SwiftUI

struct ItemListView: View {
    var body: some View {
        VStack {
            headerView
                .padding(.bottom, 16)
            
            ScrollView {
                LazyVStack {
                    ForEach((1...10), id: \.self) { _ in
                        ItemRowView()
                        
                        Divider()
                            .padding(.bottom, 8)
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
                .foregroundColor(.black)
                .frame(maxWidth: .infinity, alignment: .trailing)
                .padding(.vertical, 4)
                .padding(.horizontal)
        }
    }
}

struct ItemListView_Previews: PreviewProvider {
    static var previews: some View {
        ItemListView()
    }
}
