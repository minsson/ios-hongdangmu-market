//
//  ItemDetailView.swift
//  HongdangmuMarket
//
//  Created by minsson on 2023/04/09.
//

import SwiftUI

struct ItemDetailView: View {
    
    let item: Item
    
    let deviceWidth = UIScreen.main.bounds.width
    
    var body: some View {
        ScrollView {
            stickyHeaderImage
                .frame(height: deviceWidth)
                .padding(.bottom, 6)
            
            profileView
                .padding(.horizontal)
        }
    }
    
}

private extension ItemDetailView {
    
    var stickyHeaderImage: some View {
        GeometryReader { geometry in
            let yOffset = geometry.frame(in: .global).minY
            let deviceWidth = geometry.size.width
                        
            Image(systemName: "command.square")
                .resizable()
                .aspectRatio(contentMode: .fill)
                .frame(width: deviceWidth, height: deviceWidth + yOffset)
                .offset(y: (yOffset > 0 ? -yOffset : 0))
        }
    }
    
    var profileView: some View {
        HStack(spacing: 16) {
            AsyncImage(url: URL(string: "")) { image in
                image
                    .resizable()
                    .scaledToFit()
                    .frame(width: 60)
                    .background(Color(UIColor.systemGray4))
            } placeholder: {
                Circle()
                    .fill(Color(UIColor.systemGray2))
                    .frame(width: 60)
            }
            
            VStack(alignment: .leading, spacing: 8) {
                Text("판매자 아이디")
                    .font(.body.bold())
                
                Text("판매자 코드")
                    .font(.subheadline)
                    .foregroundColor(Color(UIColor.systemGray))
            }
            .frame(maxWidth: .infinity, alignment: .leading)
        }
    }
    
}

struct ItemDetailView_Previews: PreviewProvider {
    
    static let item = Item(
        id: 1,
        vendorID: 1,
        name: "상품 이름",
        thumbnail: "photo",
        price: 50000,
        bargainPrice: 30000,
        discountedPrice: 20000,
        stock: 100,
        createdAt: "3",
        issuedAt: "5"
    )
    
    static var previews: some View {
        ItemDetailView(item: item)
    }
    
}
