//
//  ItemAddView.swift
//  HongdangmuMarket
//
//  Created by minsson on 2023/04/09.
//

import SwiftUI

struct ItemAddView: View, ItemAddEditViewProtocol {
  @Environment(\.dismiss) private var dismiss
  @StateObject private var viewModel: ItemAddViewModel
  
  let itemAddCompletion: ((Int) -> ())?
  
  init(itemAddCompletion: ((Int) -> ())?) {
    self.itemAddCompletion = itemAddCompletion
    _viewModel = StateObject(wrappedValue: ItemAddViewModel(itemAddCompletion: itemAddCompletion))
  }
  
  var body: some View {
    headerView(
      title: "내 물건 팔기",
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
