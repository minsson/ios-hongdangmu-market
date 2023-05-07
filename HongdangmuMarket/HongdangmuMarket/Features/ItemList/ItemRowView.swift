//
//  ItemRowView.swift
//  HongdangmuMarket
//
//  Created by minsson on 2023/04/08.
//

import SwiftUI

struct ItemRowView: View {
  
  let item: Item
  let isEditable: Bool
  
  var body: some View {
    HStack(alignment: .top, spacing: 16) {
      AsyncImage(url: URL(string: item.thumbnail)) { image in
        image
          .resizable()
          .scaledToFit()
          .frame(width: 120, height: 120)
          .background(Color(UIColor.systemGray4))
          .cornerRadius(8)
      } placeholder: {
        Rectangle()
          .fill(Color(UIColor.systemGray2))
          .frame(width: 120, height: 120)
          .cornerRadius(8)
      }
      
      VStack(alignment: .leading, spacing: 8) {
        HStack {
          Text(item.name)
            .lineLimit(2)
            .font(.title3)
          
          Spacer()
          
          if isEditable {
            Image(systemName: "ellipsis")
              .rotationEffect(.degrees(90))
          }
        }
        
        Text(item.calculatedDateString())
          .font(.subheadline)
          .foregroundColor(Color(UIColor.systemGray2))
        
        HStack {
          if item.stock == 0 {
            Text("거래완료")
              .foregroundColor(.white)
              .font(.subheadline.bold())
              .padding(.vertical, 2)
              .padding(.horizontal, 4)
              .background {
                RoundedRectangle(cornerRadius: 4)
                  .fill(Color(UIColor.secondaryLabel))
              }
          }
          
          Text("\(item.bargainPrice)원")
            .font(.title3.bold())
        }
      }
      .frame(maxWidth: .infinity, alignment: .leading)
    }
  }
  
}

struct ItemRowView_Previews: PreviewProvider {
  
  static let item = Item(
    id: 1,
    vendorID: 1,
    name: "상품 이름",
    description: "",
    thumbnail: "photo",
    price: 50000,
    bargainPrice: 30000,
    discountedPrice: 20000,
    stock: 100,
    images: nil,
    vendors: nil,
    createdAt: "2023-04-10T00:00:00",
    issuedAt: "2023-04-11T00:00:00"
  )
  
  static var previews: some View {
    ItemRowView(item: item, isEditable: true)
  }
  
}
