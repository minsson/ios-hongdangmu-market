//
//  ItemListViewModel.swift
//  HongdangmuMarket
//
//  Created by minsson on 2023/04/09.
//

import Foundation

final class ItemListViewModel: ObservableObject {
    
}

private extension ItemListViewModel {
        
    func requestItemListPageData() async throws -> Data {
        guard let request: URLRequest = API.LookUpItems(pageNumber: 1, itemsPerPage: 100).urlRequest else {
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
