//
//  MySalesStatusTabBarView.swift
//  HongdangmuMarket
//
//  Created by minsson on 2023/04/14.
//

import SwiftUI

struct MySalesStatusTabBarView: View {
  
  private let tabWidth = UIScreen.main.bounds.width / 3
  private var categories: [String] {
    var categories: [String] = []
    SalesStatus.allCases.forEach { category in
      categories.append(category.rawValue)
    }
    return categories
  }
  
  @Binding var selectedTab: SalesStatus
  @Namespace private var namespace
  
  var body: some View {
    HStack(spacing: 0) {
      ForEach(SalesStatus.allCases, id: \.rawValue) { category in
        VStack {
          Text(category.rawValue)
            .foregroundColor(category == selectedTab ? .primary : Color(UIColor.systemGray4))
            .bold()
          
          Rectangle()
            .foregroundColor(Color(UIColor.systemGray6))
            .frame(height: 2)
            .overlay {
              if category == selectedTab {
                Rectangle()
                  .frame(width: tabWidth)
                  .matchedGeometryEffect(id: "selection", in: namespace)
              }
            }
            .animation(.spring(), value: selectedTab)
        }
        .onTapGesture {
          selectedTab = category
        }
      }
      .frame(maxWidth: .infinity)
    }
  }
  
}

struct MySalesStatusTabBarView_Previews: PreviewProvider {
  
  static var previews: some View {
    MySalesStatusTabBarView(selectedTab: .constant(.onSales))
  }
  
}
