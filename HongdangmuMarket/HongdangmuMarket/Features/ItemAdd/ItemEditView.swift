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
  
  let itemEditCompletion: ((Int) -> ())?
  
  init(itemID: String, itemEditCompletion: ((Int) -> ())?) {
    self.itemEditCompletion = itemEditCompletion
    _viewModel = StateObject(wrappedValue: ItemEditViewModel(itemID: itemID))
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
        imagePickerView(
          shouldPresentImagePicker: $viewModel.shouldPresentImagePicker,
          selectedImages: $viewModel.selectedImages
        )
        
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
      .sheet(isPresented: $viewModel.shouldPresentImagePicker) {
        ImagePicker(
          selectedImages: $viewModel.selectedImages,
          shouldPresentImagePicker: $viewModel.shouldPresentImagePicker
        )
      }
    }
  }
  
}

struct ItemEditView_Previews: PreviewProvider {

  static var previews: some View {
    ItemEditView(itemID: "") { _ in

    }
  }

}
