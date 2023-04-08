//
//  MainContainerView.swift
//  HongdangmuMarket
//
//  Created by minsson on 2023/04/08.
//

import SwiftUI

struct MainContainerView: View {
    @State private var selectedTagIndex: Int = 0

    init() {
        UITabBar.appearance().backgroundColor = UIColor.white
    }

    var body: some View {
        TabView(selection: $selectedTagIndex) {
            ItemListView()
                .tabItem {
                    Label("홈", systemImage: "house.fill")
                }
                .tag(0)
        }
        .tint(Color(UIColor.darkGray))
    }
}

struct MainContainerView_Previews: PreviewProvider {
    static var previews: some View {
        MainContainerView()
    }
}
