//
//  ItemAddView.swift
//  HongdangmuMarket
//
//  Created by minsson on 2023/04/09.
//

import SwiftUI

struct ItemAddView: View {
  @Environment(\.dismiss) private var dismiss
  @StateObject private var viewModel: ItemAddViewModel
  
  let itemAddCompletion: ((Int) -> ())?
  
  init(itemAddCompletion: ((Int) -> ())?) {
    self.itemAddCompletion = itemAddCompletion
    _viewModel = StateObject(wrappedValue: ItemAddViewModel(itemAddCompletion: itemAddCompletion))
  }
  
  var body: some View {
    headerView(title: "내 물건 팔기")
      .padding()
    
    Divider()
    
    ScrollView {
      ImagePickerView(shouldPresentImagePicker: $viewModel.shouldPresentImagePicker, selectedImages: $viewModel.selectedImages)
      
      Divider()
        .padding(.bottom, 8)
      
      TextField(text: $viewModel.title) {
        Text("글 제목")
      }
      .padding(.vertical, 8)
      
      Divider()
      
      TextField(text: $viewModel.price) {
        Text("₩ 가격 (선택사항)")
      }
      .keyboardType(.numberPad)
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

private extension ItemAddView {
  
  func headerView(title: String) -> some View {
    HStack() {
      Button {
        dismiss()
      } label: {
        Image(systemName: "xmark")
          .foregroundColor(Color(UIColor.systemGray))
          .font(.title3)
      }
      
      Spacer()
      
      Text(title)
        .font(.body.bold())
      
      Spacer()
      
      Button {
        viewModel.finishButtonTapped()
        dismiss()
      } label: {
        Text("완료")
          .foregroundColor(.orange)
      }
    }
  }
  
  func textEditorWithPlaceholder(for description: Binding<String>) -> some View {
    ZStack(alignment: .leading) {
      if description.wrappedValue == "" {
        TextEditor(text: .constant("신림동에 올릴 게시글 내용을 작성해주세요. (판매 금지 물품은 게시가 제한될 수 있어요.)"))
          .foregroundColor(.gray)
          .disabled(true)
      }
      
      TextEditor(text: description)
        .opacity(description.wrappedValue.isEmpty ? 0.25 : 1)
    }
  }
  
}

fileprivate struct ImagePickerView: View {
  
  @Binding var shouldPresentImagePicker: Bool
  @Binding var selectedImages: [UIImage]
  
  private let imageSize: CGFloat = 75
  private let imageCornerRadius: CGFloat = 4
  
  var body: some View {
    ScrollView(.horizontal, showsIndicators: false) {
      HStack(spacing: 20) {
        imageAddButton
        
        selectedImagesView
      }
      .padding(.bottom, 16)
    }
  }
  
}

private extension ImagePickerView {
  
  var imageAddButton: some View {
    Button {
      shouldPresentImagePicker = true
    } label: {
      ZStack {
        RoundedRectangle(cornerRadius: imageCornerRadius)
          .stroke(Color(UIColor.systemGray4))
          .frame(width: imageSize, height: imageSize)
        
        Image(systemName: "camera.fill")
          .foregroundColor(Color(UIColor.systemGray))
          .font(.title3)
      }
    }
  }
  
  var selectedImagesView: some View {
    ForEach(selectedImages, id: \.self) { image in
      Image(uiImage: image)
        .resizable()
        .aspectRatio(contentMode: .fill)
        .frame(width: imageSize, height: imageSize)
        .clipShape(RoundedRectangle(cornerRadius: imageCornerRadius))
    }
  }
  
}

struct ItemAddView_Previews: PreviewProvider {
  
  static var previews: some View {
    ItemAddView() { _ in
      
    }
  }
  
}
