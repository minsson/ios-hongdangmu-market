//
//  CachedAsyncImage.swift
//  HongdangmuMarket
//
//  Created by minsson on 2023/06/03.
//

import SwiftUI

struct CachedAsyncImage: View {
  
  @StateObject private var viewModel: CachedAsyncImageViewModel
  
  init(imageURL: String) {
    _viewModel = StateObject(wrappedValue: CachedAsyncImageViewModel(imageURL: imageURL))
  }
  
  var body: some View {
    Group {
      if viewModel.isImageReady {
        viewModel.image?
          .resizable()
      } else {
        imagePlaceholder
      }
    }
    .task {
      viewModel.imageIsNeeded()
    }
  }
  
}

private extension CachedAsyncImage {
  
  var imagePlaceholder: some View {
    Rectangle()
      .fill(Color(UIColor.systemGray2))
  }
  
}
