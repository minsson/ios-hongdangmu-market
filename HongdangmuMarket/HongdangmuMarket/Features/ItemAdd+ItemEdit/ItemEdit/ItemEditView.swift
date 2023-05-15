//
//  ItemEditView.swift
//  HongdangmuMarket
//
//  Created by minsson on 2023/05/13.
//

import SwiftUI

struct ItemEditView: View, ItemAddEditViewProtocol {
  
  @Environment(\.dismiss) private var dismiss
  @StateObject private var viewModel: ItemEditViewModel
  
  init(item: Item, selectedImages: [ItemDetailImage], itemEditCompletion: @escaping (() -> ())) {
    _viewModel = StateObject(wrappedValue: ItemEditViewModel(item: item, selectedImages: selectedImages, itemEditCompletion: itemEditCompletion))
  }
  
  var body: some View {
    VStack {
      headerView(
        title: "중고거래 글 수정하기",
        dismiss: dismiss,
        finishAction: viewModel.finishButtonTapped
      )
      .padding()
      
      Divider()
      
      ScrollView {
        ScrollView(.horizontal, showsIndicators: false) {
          HStack(spacing: 20) {
            selectedImagesView
          }
          .padding(.bottom, 16)
        }
        
        Divider()
          .padding(.bottom, 8)
        
        titleTextField($viewModel.title)
          .padding(.vertical, 8)
        
        Divider()
        
        priceTextField($viewModel.price)
          .padding(.vertical, 8)
        
        Divider()
        
        textEditorWithPlaceholder(for: $viewModel.description)
          .frame(minHeight: 160)
        
        Divider()
      }
      .padding()
    }
  }
  
}

private extension ItemEditView {
    
  var selectedImagesView: some View {
    ForEach(viewModel.selectedImages, id: \.id) { imageData in
      imageData.image
        .resizable()
        .aspectRatio(contentMode: .fill)
        .frame(width: 75, height: 75)
        .clipShape(RoundedRectangle(cornerRadius: 4))
    }
  }
  
}

struct ItemEditView_Previews: PreviewProvider {

  static let item = dummyItem
  
  static var previews: some View {
    ItemEditView(item: item, selectedImages: []) {

    }
  }

}
