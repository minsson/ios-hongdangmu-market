//
//  ItemAddView.swift
//  HongdangmuMarket
//
//  Created by minsson on 2023/04/09.
//

import SwiftUI

struct ItemAddView: View, ItemAddEditViewProtocol {
  
  @Environment(\.dismiss) private var dismiss
  @FocusState private var isKeyboardFocused: Bool
  @StateObject private var viewModel: ItemAddViewModel
  
  init(itemAddCompletion: ((String) -> ())?) {
    _viewModel = StateObject(wrappedValue: ItemAddViewModel(itemAddCompletion: itemAddCompletion))
  }
  
  var body: some View {
    NavigationView {
      VStack {
        headerView(
          title: "내 물건 팔기",
          dismiss: dismiss,
          finishAction: viewModel.finishButtonTapped
        )
        .padding()
        
        Divider()
        
        ScrollView {
          ScrollView(.horizontal, showsIndicators: false) {
            HStack(spacing: 20) {
              imagePickerButton(shouldPresentImagePicker: $viewModel.shouldPresentImagePicker)
              selectedImagesView(images: viewModel.selectedImages)
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
        .sheet(isPresented: $viewModel.shouldPresentImagePicker) {
          ImagePicker(
            selectedImages: $viewModel.selectedImages,
            shouldPresentImagePicker: $viewModel.shouldPresentImagePicker
          )
        }
      }
      .focused($isKeyboardFocused)
      .errorAlert(error: $viewModel.error)
      .keyboardToolbar(focus: $isKeyboardFocused)
    }
  }
  
}

private extension ItemAddView {
  
  func imagePickerButton(shouldPresentImagePicker: Binding<Bool>) -> some View {
    ImagePickerButton (shouldPresentImagePicker: shouldPresentImagePicker, selectedImagesCount: $viewModel.selectedImages.count)
  }
  
  func selectedImagesView(images: [UIImage], size: CGFloat = 75, cornerRadius: CGFloat = 4) -> some View {
    ForEach(images, id: \.self) { image in
      Image(uiImage: image)
        .resizable()
        .aspectRatio(contentMode: .fill)
        .frame(width: size, height: size)
        .clipShape(RoundedRectangle(cornerRadius: cornerRadius))
    }
  }
  
}

fileprivate struct ImagePickerButton: View {
  
  @Binding var shouldPresentImagePicker: Bool
  var selectedImagesCount: Int
  
  private let width: CGFloat = 75
  private let cornerRadius: CGFloat = 4
  
  var body: some View {
    imageAddButton
  }
  
}

private extension ImagePickerButton {
  
  var imageAddButton: some View {
    Button {
      shouldPresentImagePicker = true
    } label: {
      ZStack {
        RoundedRectangle(cornerRadius: cornerRadius)
          .stroke(Color(UIColor.systemGray4))
          .frame(width: width, height: width)
        
        VStack {
          Image(systemName: "camera.fill")
            .foregroundColor(Color(UIColor.systemGray))
            .font(.title3)
          
          Text("\(selectedImagesCount) / 5")
            .foregroundColor(.secondary)
        }
      }
    }
  }
  
}
