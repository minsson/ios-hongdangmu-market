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
      CachedAsyncImage(imageURL: item.thumbnail)
        .scaledToFit()
        .frame(width: 120, height: 120)
        .background(Color(UIColor.systemGray4))
        .cornerRadius(8)
      
      VStack(alignment: .leading, spacing: 8) {
        HStack {
          Text(item.name)
            .multilineTextAlignment(.leading)
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
  
  static let item = MockCenter().dummyItem
  
  static var previews: some View {
    ItemRowView(item: item, isEditable: true)
  }
  
}
