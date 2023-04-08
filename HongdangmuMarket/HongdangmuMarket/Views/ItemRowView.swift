//
//  ItemRowView.swift
//  HongdangmuMarket
//
//  Created by minsson on 2023/04/08.
//

import SwiftUI

struct ItemRowView: View {
    var body: some View {
        HStack(alignment: .top, spacing: 16) {
            Image(systemName: "photo")
                .resizable()
                .scaledToFit()
                .frame(width: 120, height: 120)
                .background(Color(UIColor.systemGray4))
                .cornerRadius(8)

            VStack(alignment: .leading, spacing: 8) {
                Text("상품 제목이 들어옵니다. 제목이 길면 최대 2줄까지만 보여줍니다. 그 이상은 ...처리되어 보이지 않습니다.")
                    .lineLimit(2)
                    .font(.title3)

                Text("3일 전")
                    .font(.subheadline)
                    .foregroundColor(Color(UIColor.systemGray2))

                Text("100만원")
                    .font(.title3.bold())
            }
            .frame(maxWidth: .infinity, alignment: .leading)
        }
    }
}

struct ItemRowView_Previews: PreviewProvider {
    static var previews: some View {
        ItemRowView()
    }
}
