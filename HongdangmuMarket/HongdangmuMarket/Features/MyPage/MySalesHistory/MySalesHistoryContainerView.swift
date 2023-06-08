//
//  MySalesHistoryContainerView.swift
//  HongdangmuMarket
//
//  Created by minsson on 2023/04/13.
//

import SwiftUI

struct MySalesHistoryContainerView: View {
  
  @StateObject private var viewModel = MySalesHistoryContainerViewModel()
  @State private var selectedSalesStatus: SalesStatus = .onSales
  
  var body: some View {
    ScrollView {
      profileView
        .padding()
      
      MySalesStatusTabBarView(selectedTab: $selectedSalesStatus)
        .padding(.bottom, 8)
      
      switch selectedSalesStatus {
      case .onSales:
        MyOnSalesItemsView(viewModel: viewModel)
      case .soldOut:
        MySoldOutItemsView(viewModel: viewModel)
      case .hidden:
        Text("숨김 뷰 구현")
      }
    }
    .fullScreenCover(isPresented: $viewModel.shouldPresentItemAddView) {
      ItemAddView() { _ in
        
      }
    }
    .errorAlert(error: $viewModel.error)
  }
  
}

private extension MySalesHistoryContainerView {
  
  var profileView: some View {
    HStack {
      VStack(alignment: .leading) {
        Text("나의 판매내역")
          .font(.title2.bold())
        
        Button {
          viewModel.shouldPresentItemAddView = true
        } label: {
          Text("글쓰기")
            .bold()
            .foregroundColor(.primary)
            .padding(.vertical, 8)
            .padding(.horizontal, 12)
            .background {
              RoundedRectangle(cornerRadius: 4)
                .foregroundColor(Color(UIColor.systemGray6))
            }
        }
      }
      
      Spacer()
      
      CircleImage(imageName: "defaultProfileImage")
        .frame(width: 90)
    }
  }
  
}

struct MySalesHistoryContainerView_Previews: PreviewProvider {
  
  static var previews: some View {
    MySalesHistoryContainerView()
  }
  
}
