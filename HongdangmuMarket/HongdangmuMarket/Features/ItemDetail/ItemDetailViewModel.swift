//
//  ItemDetailViewModel.swift
//  HongdangmuMarket
//
//  Created by minsson on 2023/04/09.
//

import Foundation

final class ItemDetailViewModel: ObservableObject {
    
    @Published var item: Item?
    @Published var itemID: String?
        
}

private extension ItemDetailViewModel {
        
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
