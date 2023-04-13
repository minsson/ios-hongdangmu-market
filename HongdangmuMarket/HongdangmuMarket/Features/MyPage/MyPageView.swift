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
            headerView
            
            profileView
            
            MyPageSectionsView()
            
            Spacer()
        }
    }
    
}

private extension MyPageView {
    
    var headerView: some View {
        searchButton
    }
    
    var searchButton: some View {
        Button {
            // TODO: 기능 구현
        } label: {
            Image(systemName: "gearshape")
                .font(.title2)
                .foregroundColor(Color(UIColor.darkGray))
                .frame(maxWidth: .infinity, alignment: .trailing)
                .padding(.vertical, 4)
                .padding(.horizontal)
        }
    }
    
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

fileprivate struct MyPageSectionsView: View {
    
    var body: some View {
        VStack(alignment: .leading, spacing: 24) {
            Text("나의 거래")
                .bold()
            
            sectionRowView(iconString: "heart", title: "관심목록")
            sectionRowView(iconString: "note.text", title: "판매내역")
                    
        }
        .frame(maxWidth: .infinity, alignment: .leading)
        .padding()
    }
    
}

private extension MyPageSectionsView {
    
    func sectionRowView(iconString: String, title: String) -> some View {
        HStack(spacing: 12) {
            Image(systemName: iconString)
                .font(.title2)
            
            Text(title)
        }
    }
    
}

struct MyPageView_Previews: PreviewProvider {
    
    static var previews: some View {
        MyPageView()
    }
    
}
