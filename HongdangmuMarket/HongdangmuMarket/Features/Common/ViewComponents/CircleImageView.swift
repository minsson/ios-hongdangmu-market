//
//  ProfileImageView.swift
//  HongdangmuMarket
//
//  Created by minsson on 2023/04/14.
//

import SwiftUI

struct CircleImage: View {
  
  let imageName: String
  
  var body: some View {
    Image(imageName)
      .resizable()
      .scaledToFit()
      .foregroundColor(.gray)
      .clipShape(Circle())
  }
  
}

struct ProfileImageView_Previews: PreviewProvider {
  
  static var previews: some View {
    CircleImage(imageName: "defaultProfileImage")
  }
  
}
