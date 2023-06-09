//
//  ItemDetailView.swift
//  HongdangmuMarket
//
//  Created by minsson on 2023/04/09.
//

import SwiftUI

struct ItemDetailView: View {
  
  @Environment(\.dismiss) private var dismiss
  @StateObject private var viewModel: ItemDetailViewModel
  
  private let deviceWidth = UIScreen.main.bounds.width
  
  private let gradientOnImage = LinearGradient(
    gradient: Gradient(stops: [
      .init(color: .gray, location: 0),
      .init(color: .clear, location: 0.25),
    ]),
    startPoint: .top,
    endPoint: .bottom
  )
  
  init(itemID: String, itemDeletionCompletion: @escaping () -> Void) {
    _viewModel = StateObject(wrappedValue: ItemDetailViewModel(itemID: itemID, itemDeletionCompletion: itemDeletionCompletion))
  }
  
  var body: some View {
    VStack {
      ScrollView {
        stickyHeaderImage
          .frame(height: deviceWidth)
          .padding(.bottom, 6)
        
        profile
          .padding(.horizontal)
          .padding(.bottom, 6)
        
        Divider()
          .padding(.horizontal)
        
        itemInformation
          .padding()
      }
      
      Divider()
        .padding(.top, -7)
      
      purchaseBar
        .padding(.horizontal)
    }
    .ignoresSafeArea(edges: .top)
    .task {
      await viewModel.viewOnAppearTask()
    }
    .navigationBarBackButtonHidden()
    .toolbar {
      ToolbarItem(placement: .navigationBarLeading) {
        leadingToolbarItems
      }
      
      ToolbarItemGroup(placement: .navigationBarTrailing) {
        trailingToolbarItems
      }
    }
    .confirmationDialog("", isPresented: $viewModel.shouldPresentConfirmationDialog) {
      confirmationDialogButtons
    }
    .fullScreenCover(isPresented: $viewModel.shouldPresentItemEditView) {
      ItemEditView(item: viewModel.item) {
        Task {
          await viewModel.viewOnAppearTask()
        }
      }
    }
    .errorAlert(error: $viewModel.error)
  }
  
}

private extension ItemDetailView {
  
  var leadingToolbarItems: some View {
    HStack {
      Button {
        dismiss()
      } label: {
        Image(systemName: "chevron.left")
      }
      .padding(.horizontal, 2)
      
      Image(systemName: "house")
    }
    .foregroundColor(.white)
  }
  
  var trailingToolbarItems: some View {
    HStack {
      Button {
        viewModel.shareButtonTapped()
      } label: {
        Image(systemName: "square.and.arrow.up")
          .padding(.horizontal, 2)
      }
      
      Button {
        viewModel.moreActionButtonTapped()
      } label: {
        Image(systemName: "ellipsis")
          .rotationEffect(.degrees(90))
      }
    }
    .foregroundColor(.white)
  }
  
  @ViewBuilder
  var confirmationDialogButtons: some View {
    let itemOwner: ItemOwner = viewModel.checkItemOwner()
    switch itemOwner {
    case .myItem:
      Button("게시글 수정") {
        viewModel.shouldPresentItemEditView = true
      }
      
      Button("삭제", role: .destructive) {
        viewModel.deleteButtonTapped()
        dismiss()
      }
    case .otherUsersItem:
      Button("신고") {
        
      }
      
      Button("이 사용자의 글 보지 않기") {

      }
    }
  }
  
  var stickyHeaderImage: some View {
    GeometryReader { geometry in
      let yOffset = geometry.frame(in: .global).minY
      let deviceWidth = geometry.size.width
      
      TabView {
        ForEach(viewModel.item.images) { imageData in
          CachedAsyncImageView(imageURL: imageData.url, withSize: CGSize(width: deviceWidth, height: deviceWidth))
            .aspectRatio(contentMode: .fill)
            .overlay {
              gradientOnImage
            }
        }
      }
      .background { Color.secondary }
      .tabViewStyle(.page)
      .frame(width: deviceWidth, height: deviceWidth + (yOffset > 0 ? yOffset : 0))
      .offset(y: (yOffset > 0 ? -yOffset : 0))
    }
  }
  
  var profile: some View {
    HStack(spacing: 16) {
      CircleImage(imageName: "defaultProfileImage")
        .frame(width: 60)
      
      VStack(alignment: .leading, spacing: 8) {
        Text(String(viewModel.item.vendors.name))
          .font(.body.bold())
        
        Text(String(viewModel.item.vendors.id))
          .font(.subheadline)
          .foregroundColor(Color(UIColor.systemGray))
      }
      .frame(maxWidth: .infinity, alignment: .leading)
    }
  }
  
  var itemInformation: some View {
    VStack() {
      HStack(spacing: 0) {
        Text(viewModel.item.stock == 0 ? "거래완료 " : "")
          .foregroundColor(Color(UIColor.systemGray))
        
        Text(viewModel.item.name)
      }
      .font(.title2.bold())
      .frame(maxWidth: .infinity, alignment: .leading)
      .padding(.bottom, 4)
      
      Text(viewModel.item.calculatedDateString())
        .font(.subheadline)
        .foregroundColor(Color(UIColor.systemGray2))
        .frame(maxWidth: .infinity, alignment: .leading)
        .padding(.bottom, 16)
      
      Text(viewModel.item.description)
        .frame(maxWidth: .infinity, alignment: .leading)
    }
  }
  
  var purchaseBar: some View {
    HStack {
      Image(systemName: "heart.fill")
        .font(.title2)
        .foregroundColor(.orange)
      
      Rectangle()
        .foregroundColor(Color(UIColor.systemGray5))
        .frame(width: 1)
        .frame(maxHeight: 45)
        .padding(.horizontal, 8)
      
      VStack(alignment: .leading) {
        Text("\(viewModel.item.bargainPrice)원")
          .font(.title3.bold())
        Text("가격 제안 불가")
          .foregroundColor(Color.secondary)
          .font(.headline.bold())
      }
      
      Spacer()
      
      Button {
        // TODO: 기능 구현
      } label: {
        ZStack {
          RoundedRectangle(cornerRadius: 4)
            .foregroundColor(viewModel.item.stock == 0 ? Color(UIColor.tertiarySystemFill) : .orange)
            .frame(width: 100, height: 40)
          
          Text("구매하기")
            .foregroundColor(viewModel.item.stock == 0 ? .secondary : .white)
            .font(.body.bold())
        }
      }
      .disabled(viewModel.item.stock == 0)
    }
  }
  
}

struct ItemDetailView_Previews: PreviewProvider {
  
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
    ItemDetailView(itemID: dummyItem.id) {
      
    }
  }
  
}
