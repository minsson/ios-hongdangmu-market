//
//  MySalesHistoryContainerView.swift
//  HongdangmuMarket
//
//  Created by minsson on 2023/04/13.
//

import SwiftUI

struct MySalesHistoryContainerView: View {
    
    @State private var selectedSalesStatus: SalesStatus = .onSales
    
    var body: some View {
        ScrollView {
            profileView
                .padding()
            
            MySalesStatusTabBarView(selectedTab: $selectedSalesStatus)
        }
    }
    
}

private extension MySalesHistoryContainerView {
    
    var profileView: some View {
        HStack {
            VStack(alignment: .leading) {
                Text("나의 판매내역")
                    .font(.title2.bold())
                
                Button {
                    // TODO: 기능 구현
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
            
            CircleImageView(imageName: "defaultProfileImage")
                .frame(width: 90)
        }
    }
    
}

struct MySalesHistoryContainerView_Previews: PreviewProvider {
    
    static var previews: some View {
        MySalesHistoryContainerView()
    }
    
}