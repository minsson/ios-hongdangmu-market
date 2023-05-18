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
  
  let itemID: String
  let deviceWidth = UIScreen.main.bounds.width
  
  init(itemID: String) {
    self.itemID = itemID
    _viewModel = StateObject(wrappedValue: ItemDetailViewModel(itemID: itemID))
  }
  
  var body: some View {
    VStack {
      ScrollView {
        stickyHeaderImage
          .frame(height: deviceWidth)
          .padding(.bottom, 6)
        
        profileView
          .padding(.horizontal)
          .padding(.bottom, 6)
        
        Divider()
          .padding(.horizontal)
        
        itemInformationView
          .padding()
      }
      
      Divider()
        .padding(.top, -7)
      
      purchaseView
        .padding(.horizontal)
    }
    .ignoresSafeArea(edges: .top)
    .task {
      do {
        try await viewModel.viewWillAppear()
      } catch {
        // TODO: 에러 처리
      }
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
      ItemEditView(item: viewModel.item, selectedImages: viewModel.images) {
        Task {
          try await viewModel.viewWillAppear()
        }
      }
    }
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
        ForEach(viewModel.images, id: \.id) { image in
          image.image
            .resizable()
            .aspectRatio(contentMode: .fill)
        }
      }
      .background { Color.secondary }
      .tabViewStyle(.page)
      .frame(width: deviceWidth, height: deviceWidth + (yOffset > 0 ? yOffset : 0))
      .offset(y: (yOffset > 0 ? -yOffset : 0))
    }
  }
  
  var profileView: some View {
    HStack(spacing: 16) {
      CircleImageView(imageName: "defaultProfileImage")
        .frame(width: 60)
      
      VStack(alignment: .leading, spacing: 8) {
        Text(String(viewModel.item.vendors?.name ?? ""))
          .font(.body.bold())
        
        Text(String(viewModel.item.vendors?.id ?? 0))
          .font(.subheadline)
          .foregroundColor(Color(UIColor.systemGray))
      }
      .frame(maxWidth: .infinity, alignment: .leading)
    }
  }
  
  var itemInformationView: some View {
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
  
  var purchaseView: some View {
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
  
  static let item = dummyItem
  
  static var previews: some View {
    ItemDetailView(itemID: item.id)
  }
  
}
