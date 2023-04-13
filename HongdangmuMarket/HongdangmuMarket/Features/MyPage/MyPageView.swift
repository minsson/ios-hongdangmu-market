//
//  MyPageView.swift
//  HongdangmuMarket
//
//  Created by minsson on 2023/04/13.
//

import SwiftUI

struct MyPageView: View {
    
    var body: some View {
        VStack {
            profileView
        }
    }
    
}

private extension MyPageView {
    
    var profileView: some View {
        HStack {
            Image(systemName: "person")
                .resizable()
                .scaledToFit()
                .foregroundColor(.gray)
                .frame(width: 38)
                .background(Color(UIColor.systemGray5))
                .clipShape(Circle())
                .padding(.trailing, 8)
            
            Text("당근을따라한홍당무")
                .font(.title2.bold())
            
            Spacer()
            
            Text("프로필 보기")
                .foregroundColor(.primary)
                .font(.subheadline.bold())
                .padding(6)
                .background {
                    RoundedRectangle(cornerRadius: 4)
                        .fill(Color(UIColor.tertiarySystemFill))
                }
        }
        .padding()
    }
    
}

struct MyPageView_Previews: PreviewProvider {
    
    static var previews: some View {
        MyPageView()
    }
    
}
