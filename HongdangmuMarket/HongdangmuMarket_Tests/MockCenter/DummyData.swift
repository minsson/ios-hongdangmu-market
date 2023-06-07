//
//  DummyData.swift
//  HongdangmuMarket
//
//  Created by minsson on 2023/05/14.
//

import Foundation
@testable import HongdangmuMarket

struct DummyData {
  
  let dummyItem: Item = Item(
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
    images: [],
    vendors: Vendor(id: 0, name: "vendorName"),
    createdAt: Date(timeIntervalSinceNow: -86400),
    issuedAt: Date.now
  )
  
  let dummyItemListPage: ItemListPage = ItemListPage(
    pageNumber: 1,
    itemsPerPage: 50,
    totalCount: 100,
    items: [
      Item(id: "1", vendorID: "vendorID", name: "Name", description: "Description", thumbnail: "", price: 100, bargainPrice: 50, discountedPrice: 50, stock: 1, images: [], vendors: Vendor(id: 1, name: "VendorName"), createdAt: Date.now, issuedAt: Date.now),
      Item(id: "2", vendorID: "vendorID", name: "Name 2", description: "Description", thumbnail: "", price: 100, bargainPrice: 50, discountedPrice: 50, stock: 1, images: [], vendors: Vendor(id: 1, name: "VendorName"), createdAt: Date.now, issuedAt: Date.now)
    ],
    hasNext: true
  )
  
}
