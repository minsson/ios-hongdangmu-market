//
//  ItemEditView.swift
//  HongdangmuMarket
//
//  Created by minsson on 2023/05/13.
//

import SwiftUI

struct ItemEditView: View, ItemAddEditViewProtocol {
  
  @Environment(\.dismiss) private var dismiss
  @FocusState private var isKeyboardFocused: Bool
  @StateObject private var viewModel: ItemEditViewModel
  
  init(item: Item, itemEditCompletion: @escaping (() -> ())) {
    _viewModel = StateObject(wrappedValue: ItemEditViewModel(item: item, itemEditCompletion: itemEditCompletion))
  }
  
  var body: some View {
    NavigationView {
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
              selectedImages
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
      .focused($isKeyboardFocused)
      .keyboardToolbar(focus: $isKeyboardFocused)
      .errorAlert(error: $viewModel.error)
    }
  }
  
}

private extension ItemEditView {
  
  var selectedImages: some View {
    ForEach(viewModel.item.images) { imageData in
      CachedAsyncImageView(imageURL: imageData.url, withSize: CGSize(width: 75, height: 75))
        .aspectRatio(contentMode: .fill)
        .frame(width: 75, height: 75)
        .clipShape(RoundedRectangle(cornerRadius: 4))
    }
  }
  
}

struct ItemEditView_Previews: PreviewProvider {
  
  static let dummyItem: Item = Item(
    id: "1",
    vendorID: "1",
    name: "상품 이름",
    description: """
          iPhone 7 Plus 이후 모델을 보상 판매하고 ₩40,000-₩780,000 상당의 크레딧을 받으세요.
          """,
    thumbnail: "photo",
    price: 50000,
    bargainPrice: 30000,
    discountedPrice: 20000,
    stock: 100,
    images: [],
    vendors: Vendor(id: 0, name: "vendorName"),
    createdAt: Date(timeIntervalSinceNow: -86400),
    issuedAt: Date.now
  )
  
  static var previews: some View {
    ItemEditView(item: dummyItem) {
      
    }
  }
  
}
