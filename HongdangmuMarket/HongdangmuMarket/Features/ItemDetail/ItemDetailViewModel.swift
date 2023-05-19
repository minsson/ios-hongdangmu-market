//
//  ItemDetailViewModel.swift
//  HongdangmuMarket
//
//  Created by minsson on 2023/04/09.
//

import SwiftUI

final class ItemDetailViewModel: ObservableObject {
  
  @Published var itemID: String
  @Published var shouldPresentConfirmationDialog = false
  @Published var shouldPresentItemEditView = false
  @Published private(set) var item: Item = Item(id: "", vendorID: "", name: "", description: "", thumbnail: "", price: 0, bargainPrice: 0, discountedPrice: 0, stock: 0, images: nil, vendors: nil, createdAt: Date.now, issuedAt: Date.now)
  @Published private(set) var images: [ItemDetailImage] = []
  
  let itemDeletionCompletion: () -> Void
  
  private let openMarketAPIService = OpenMarketAPIService()
  
  init(itemID: String, itemDeletionCompletion: @escaping () -> Void) {
    self.itemID = itemID
    self.itemDeletionCompletion = itemDeletionCompletion
  }
  
  func viewWillAppear() async throws {
    do {
      let data: Data = try await openMarketAPIService.itemDetailData(itemID: itemID)
      let item = try DataToEntityConverter().convert(data: data, to: ItemDTO.self)
      try await requestImages(for: item)
      
      await MainActor.run { [weak self] in
        self?.item = item
      }
    } catch {
      throw error
    }
  }
  
  func shareButtonTapped() {
    let activityViewController = UIActivityViewController(activityItems: [shareMessage], applicationActivities: nil)
    if let windowScene = UIApplication.shared.connectedScenes.first as? UIWindowScene,
       let window = windowScene.windows.first {
        window.rootViewController?.present(activityViewController, animated: true, completion: nil)
    }
  }
  
  func deleteButtonTapped() {
    Task {
      do {
        itemDeletionCompletion()
        let _ = try await openMarketAPIService.deleteItem(id: itemID)
      } catch {
        print(error.localizedDescription)
      }
    }
  }
  
  func moreActionButtonTapped() {
    shouldPresentConfirmationDialog = true
  }
  
  func checkItemOwner() -> ItemOwner {
    return item.vendors?.name == LoginData.shared.nickname ? .myItem : .otherUsersItem
  }
  
}

private extension ItemDetailViewModel {
  
  var shareMessage: String {
    return "홍당무 마켓에서는 \(item.name) 상품이 \(item.bargainPrice)원이에요!"
  }
  
  func requestImages(for item: Item) async throws {
    await MainActor.run { [weak self] in
      self?.images.removeAll()
    }
    
    await withThrowingTaskGroup(of: Void.self) { group in
      item.images?.forEach { itemImage in
        group.addTask { [weak self] in
          guard let data = try await self?.openMarketAPIService.itemDetailImageData(for: itemImage.url) else {
            throw URLError(.badURL)
          }
          
          guard let uiImage = UIImage(data: data) else {
            throw URLError(.badServerResponse)
          }

          let image = Image(uiImage: uiImage)
          let detailImage = ItemDetailImage(id: itemImage.id, image: image)
          
          await MainActor.run { [weak self] in
            self?.images.append(detailImage)
          }
        }
      }
    }
  }
  
}
