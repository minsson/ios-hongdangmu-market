//
//  ItemDetailViewModel.swift
//  HongdangmuMarket
//
//  Created by minsson on 2023/04/09.
//

import SwiftUI

final class ItemDetailViewModel: ObservableObject, ViewModelErrorHandlingProtocol {
  
  @Published var itemID: String
  @Published var shouldPresentConfirmationDialog = false
  @Published var shouldPresentItemEditView = false
  @Published var error: HongdangmuError?
  @Published private(set) var item: Item = Item(id: "", vendorID: "", name: "", description: "", thumbnail: "", price: 0, bargainPrice: 0, discountedPrice: 0, stock: 0, images: [], vendors: Vendor(id: 0, name: ""), createdAt: Date.now, issuedAt: Date.now)
  
  private let itemDeletionCompletion: () -> Void
  private let openMarketAPIService = OpenMarketAPIService()
  
  init(itemID: String, itemDeletionCompletion: @escaping () -> Void) {
    self.itemID = itemID
    self.itemDeletionCompletion = itemDeletionCompletion
  }
  
  func viewWillAppear() async {
    await handleError {
      let itemDetail: Item = try await openMarketAPIService.itemDetail(itemID: itemID)
      
      await MainActor.run { [weak self] in
        self?.item = itemDetail
      }
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
    Task { [weak self] in
      do {
        self?.itemDeletionCompletion()
        try await self?.openMarketAPIService.deleteItem(id: self?.itemID ?? "")
      } catch let error as OpenMarketAPIError {
        self?.error = HongdangmuError.openMarketAPIServiceError(error)
      } catch {
        self?.error = HongdangmuError.unknownError
      }
    }
  }
  
  func moreActionButtonTapped() {
    shouldPresentConfirmationDialog = true
  }
  
  func checkItemOwner() -> ItemOwner {
    return item.vendors.name == LoginData.shared.nickname ? .myItem : .otherUsersItem
  }
  
}

private extension ItemDetailViewModel {
  
  var shareMessage: String {
    return "홍당무 마켓에서는 \(item.name) 상품이 \(item.bargainPrice)원이에요!"
  }
  
}
