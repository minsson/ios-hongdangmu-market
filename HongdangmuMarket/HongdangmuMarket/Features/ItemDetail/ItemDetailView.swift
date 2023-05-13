//
//  ItemDetailView.swift
//  HongdangmuMarket
//
//  Created by minsson on 2023/04/09.
//

import SwiftUI

struct ItemDetailView: View {
  
  @Environment(\.dismiss) private var dismiss
  @EnvironmentObject private var userInformation: UserInformation
  @StateObject private var viewModel = ItemDetailViewModel()
  
  let itemID: String
  let deviceWidth = UIScreen.main.bounds.width
  
  init(itemID: String) {
    self.itemID = itemID
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
    .task {
      do {
        viewModel.itemID = itemID
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
  }
  
}

private extension ItemDetailView {
  
  private var leadingToolbarItems: some View {
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
  
  private var trailingToolbarItems: some View {
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
    switch viewModel.checkItemOwner(userInformation: userInformation) {
    case .myItem:
      Button("게시글 수정") {
        
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
      
      AsyncImage(url: URL(string: viewModel.item?.images?[0].url ?? "")) { image in
        image
          .resizable()
          .aspectRatio(contentMode: .fill)
          .frame(width: deviceWidth, height: deviceWidth + (yOffset > 0 ? yOffset : 0))
          .offset(y: (yOffset > 0 ? -yOffset : 0))
      } placeholder: {
        Rectangle()
          .fill(Color(UIColor.systemGray6))
          .aspectRatio(contentMode: .fill)
          .frame(width: deviceWidth, height: deviceWidth + (yOffset > 0 ? yOffset : 0))
          .offset(y: (yOffset > 0 ? -yOffset : 0))
      }
    }
  }
  
  var profileView: some View {
    HStack(spacing: 16) {
      CircleImageView(imageName: "defaultProfileImage")
        .frame(width: 60)
      
      VStack(alignment: .leading, spacing: 8) {
        Text(String(viewModel.item?.vendors?.name ?? ""))
          .font(.body.bold())
        
        Text(String(viewModel.item?.vendors?.id ?? 0))
          .font(.subheadline)
          .foregroundColor(Color(UIColor.systemGray))
      }
      .frame(maxWidth: .infinity, alignment: .leading)
    }
  }
  
  var itemInformationView: some View {
    VStack() {
      HStack(spacing: 0) {
        Text(viewModel.item?.stock == 0 ? "거래완료 " : "")
          .foregroundColor(Color(UIColor.systemGray))
        
        Text(viewModel.item?.name ?? "")
      }
      .font(.title2.bold())
      .frame(maxWidth: .infinity, alignment: .leading)
      .padding(.bottom, 4)
      
      Text(viewModel.item?.calculatedDateString() ?? "")
        .font(.subheadline)
        .foregroundColor(Color(UIColor.systemGray2))
        .frame(maxWidth: .infinity, alignment: .leading)
        .padding(.bottom, 16)
      
      Text(viewModel.item?.description ?? "")
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
        Text("\(viewModel.item?.bargainPrice ?? 0)원")
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
            .foregroundColor(viewModel.item?.stock == 0 ? Color(UIColor.tertiarySystemFill) : .orange)
            .frame(width: 100, height: 40)
          
          Text("구매하기")
            .foregroundColor(viewModel.item?.stock == 0 ? .secondary : .white)
            .font(.body.bold())
        }
      }
      .disabled(viewModel.item?.stock == 0)
    }
  }
  
}

struct ItemDetailView_Previews: PreviewProvider {
  
  static let item = Item(
    id: "1",
    vendorID: "1",
    name: "상품 이름",
    description: """
            iPhone 7 Plus 이후 모델을 보상 판매하고 ₩40,000-₩780,000 상당의 크레딧을 받으세요. 한층 부담 없이 iPhone 14 또는 iPhone 14 Pro로 업그레이드할 수 있는 방법이죠.\n\n자신에게 맞는 결제 옵션 선택은 물론, 보상 판매를 통해 더 저렴한 가격에 살 수 있고, 구매한 폰의 설정도 신속하게 할 수 있습니다. 게다가 채팅 상담을 통해 궁금증을 풀어줄 스페셜리스트도 기다리고 있답니다. \n\n마그네틱 케이스나 카드지갑, 아니면 둘 모두를 한꺼번에 착. 그리고 무선 충전도 더욱 빠르게. \n\n하나는 열쇠에, 또 하나는 백팩에. 어디 두었는지 기억이 나지 않을 땐, 간편하게 ‘나의 찾기’ 앱을 활용해보세요.\n\n다양한 AirPods 모델 살펴보고 가장 취향에 맞는 것 고르기.
            """,
    thumbnail: "photo",
    price: 50000,
    bargainPrice: 30000,
    discountedPrice: 20000,
    stock: 100,
    images: nil,
    vendors: nil,
    createdAt: "3",
    issuedAt: "5"
  )
  
  static var previews: some View {
    ItemDetailView(itemID: item.id)
  }
  
}
