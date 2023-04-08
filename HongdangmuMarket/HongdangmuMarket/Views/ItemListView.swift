//
//  ItemListView.swift
//  HongdangmuMarket
//
//  Created by minsson on 2023/04/08.
//

import SwiftUI

struct ItemListView: View {
    var body: some View {
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

struct ItemListView_Previews: PreviewProvider {
    static var previews: some View {
        ItemListView()
    }
}
