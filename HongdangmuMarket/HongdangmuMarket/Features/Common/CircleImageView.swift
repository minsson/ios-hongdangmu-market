//
//  ProfileImageView.swift
//  HongdangmuMarket
//
//  Created by minsson on 2023/04/14.
//

import SwiftUI

struct CircleImageView: View {
    
    let imageName: String
    
    var body: some View {
        Image(systemName: imageName)
            .resizable()
            .scaledToFit()
            .foregroundColor(.gray)
            .background(Color(UIColor.systemGray5))
            .clipShape(Circle())
    }
    
}

struct ProfileImageView_Previews: PreviewProvider {
    
    static var previews: some View {
        CircleImageView(imageName: "person")
    }
    
}
