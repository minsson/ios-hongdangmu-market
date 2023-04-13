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
        NavigationView {
            TabView(selection: $selectedTagIndex) {
                ItemListView()
                .tabItem {
                    Label("홈", systemImage: "house")
                }
                .tag(0)
                
                MyPageView()
                .tabItem {
                    Label("나의 홍당무", systemImage: "person")
                }
                .tag(1)
            }
            .tint(.primary)
        }
    }
    
}

struct MainContainerView_Previews: PreviewProvider {
    
    static var previews: some View {
        MainContainerView()
    }
    
}
