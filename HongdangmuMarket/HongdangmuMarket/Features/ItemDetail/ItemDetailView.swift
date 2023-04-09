//
//  ItemDetailView.swift
//  HongdangmuMarket
//
//  Created by minsson on 2023/04/09.
//

import SwiftUI

struct ItemDetailView: View {
    
    let item: Item
    
    let deviceWidth = UIScreen.main.bounds.width
    
    var body: some View {
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
    }
    
}

private extension ItemDetailView {
    
    var stickyHeaderImage: some View {
        GeometryReader { geometry in
            let yOffset = geometry.frame(in: .global).minY
            let deviceWidth = geometry.size.width
            
            Image(systemName: "command.square")
                .resizable()
                .aspectRatio(contentMode: .fill)
                .frame(width: deviceWidth, height: deviceWidth + (yOffset > 0 ? yOffset : 0))
                .offset(y: (yOffset > 0 ? -yOffset : 0))
        }
    }
    
    var profileView: some View {
        HStack(spacing: 16) {
            AsyncImage(url: URL(string: "")) { image in
                image
                    .resizable()
                    .scaledToFit()
                    .frame(width: 60)
                    .background(Color(UIColor.systemGray4))
            } placeholder: {
                Circle()
                    .fill(Color(UIColor.systemGray2))
                    .frame(width: 60)
            }
            
            VStack(alignment: .leading, spacing: 8) {
                Text("판매자 아이디")
                    .font(.body.bold())
                
                Text("판매자 코드")
                    .font(.subheadline)
                    .foregroundColor(Color(UIColor.systemGray))
            }
            .frame(maxWidth: .infinity, alignment: .leading)
        }
    }
    
    var itemInformationView: some View {
        VStack() {
            HStack() {
                Text("거래완료")
                    .foregroundColor(Color(UIColor.systemGray))
                
                Text("아이폰")
            }
            .font(.title2.bold())
            .frame(maxWidth: .infinity, alignment: .leading)
            .padding(.bottom, 4)
            
            Text("끌올 1일 전")
                .font(.subheadline)
                .foregroundColor(Color(UIColor.systemGray2))
                .frame(maxWidth: .infinity, alignment: .leading)
                .padding(.bottom, 16)
            
            Text("""
            iPhone 7 Plus 이후 모델을 보상 판매하고 ₩40,000-₩780,000 상당의 크레딧을 받으세요. 한층 부담 없이 iPhone 14 또는 iPhone 14 Pro로 업그레이드할 수 있는 방법이죠.\n\n자신에게 맞는 결제 옵션 선택은 물론, 보상 판매를 통해 더 저렴한 가격에 살 수 있고, 구매한 폰의 설정도 신속하게 할 수 있습니다. 게다가 채팅 상담을 통해 궁금증을 풀어줄 스페셜리스트도 기다리고 있답니다. \n\n마그네틱 케이스나 카드지갑, 아니면 둘 모두를 한꺼번에 착. 그리고 무선 충전도 더욱 빠르게. \n\n하나는 열쇠에, 또 하나는 백팩에. 어디 두었는지 기억이 나지 않을 땐, 간편하게 ‘나의 찾기’ 앱을 활용해보세요.\n\n다양한 AirPods 모델 살펴보고 가장 취향에 맞는 것 고르기.
            """)
            .frame(maxWidth: .infinity, alignment: .leading)
        }
    }
    
}

struct ItemDetailView_Previews: PreviewProvider {
    
    static let item = Item(
        id: 1,
        vendorID: 1,
        name: "상품 이름",
        thumbnail: "photo",
        price: 50000,
        bargainPrice: 30000,
        discountedPrice: 20000,
        stock: 100,
        createdAt: "3",
        issuedAt: "5"
    )
    
    static var previews: some View {
        ItemDetailView(item: item)
    }
    
}
