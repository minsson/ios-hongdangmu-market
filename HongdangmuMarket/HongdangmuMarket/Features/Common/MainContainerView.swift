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
                
                Text("나의 홍당무 페이지로 교체")
                .tabItem {
                    Label("나의 홍당무", systemImage: "person")
                }
                .tag(1)
            }
            .tint(Color(UIColor.darkGray))
        }
        .tint(.white)
    }
    
}

struct MainContainerView_Previews: PreviewProvider {
    
    static var previews: some View {
        MainContainerView()
    }
    
}
