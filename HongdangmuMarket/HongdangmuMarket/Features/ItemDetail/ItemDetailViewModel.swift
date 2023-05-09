//
//  ItemDetailViewModel.swift
//  HongdangmuMarket
//
//  Created by minsson on 2023/04/09.
//

import UIKit

final class ItemDetailViewModel: ObservableObject {
  
  @Published var itemID: String?
  @Published private(set) var item: Item?
  
  func viewWillAppear() async throws {
    do {
      let data: Data = try await requestItemDetailData()
      let item = try DataToEntityConverter().convert(data: data, to: ItemDTO.self)
      
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
  
}

private extension ItemDetailViewModel {
  
  var shareMessage: String {
    guard let itemName = item?.name,
          let itemBargainPrice = item?.bargainPrice else {
      return ""
    }
    return "홍당무 마켓에서는 \(itemName) 상품이 \(itemBargainPrice)원이에요!"
  }
  
  func requestItemDetailData() async throws -> Data {
    guard let itemID else {
      // TODO: 에러 처리
      fatalError()
    }
    
    guard let request: URLRequest = API.LookUpItemDetail(productID: String(itemID)).urlRequest else {
      throw URLError(.badURL)
    }
    
    do {
      let data = try await NetworkManager().execute(request)
      return data
    } catch {
      print(error.localizedDescription)
      throw error
    }
  }
  
}
