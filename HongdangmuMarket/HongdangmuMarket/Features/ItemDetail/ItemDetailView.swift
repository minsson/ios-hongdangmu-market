//
//  ItemDetailView.swift
//  HongdangmuMarket
//
//  Created by minsson on 2023/04/09.
//

import SwiftUI

struct ItemDetailView: View {
    
    let deviceWidth = UIScreen.main.bounds.width
    
    var body: some View {
        ScrollView {
            stickyHeaderImage
                .frame(height: deviceWidth)
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
    
}

struct ItemDetailView_Previews: PreviewProvider {
    
    static var previews: some View {
        ItemDetailView()
    }
    
}
