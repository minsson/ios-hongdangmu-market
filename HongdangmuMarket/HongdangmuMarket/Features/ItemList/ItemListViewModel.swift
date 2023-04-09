//
//  ItemListViewModel.swift
//  HongdangmuMarket
//
//  Created by minsson on 2023/04/09.
//

import Foundation

final class ItemListViewModel: ObservableObject {
    
    @Published var itemListPageData: ItemListPage?
    @Published var shouldPresentItemAddView: Bool = false
    
    func viewWillAppear() async throws {
        do {
            let data: Data = try await requestItemListPageData(pageNumber: pageCounter)
            let itemListPage = try DataToEntityConverter().convert(data: data, to: ItemListPageDTO.self)
            
            await MainActor.run {
                itemListPageData = itemListPage
            }
        } catch {
            throw error
        }
    }
    
    func addButtonTapped() {
        shouldPresentItemAddView = true
    }
    
}

private extension ItemListViewModel {
        
    func requestItemListPageData(pageNumber: Int) async throws -> Data {
        guard let request: URLRequest = API.LookUpItems(pageNumber: pageNumber, itemsPerPage: 100).urlRequest else {
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
