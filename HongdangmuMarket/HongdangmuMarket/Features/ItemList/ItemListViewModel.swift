//
//  ItemListViewModel.swift
//  HongdangmuMarket
//
//  Created by minsson on 2023/04/09.
//

import Foundation

final class ItemListViewModel: ObservableObject {
    
    @Published var shouldPresentItemAddView: Bool = false
    @Published var items: [Item] = []
    
    private(set) var itemListPageData: ItemListPage?
    private var pageCounter = 1
    
    func viewWillAppear() async throws {
        try? await retrieveItems()
    }
    
    func listScrollIsAlmostOver() async throws {
        try? await retrieveItems()
    }
    
    func addButtonTapped() {
        shouldPresentItemAddView = true
    }
    
}

private extension ItemListViewModel {
    func retrieveItems() async throws {
        do {
            let data: Data = try await requestItemListPageData(pageNumber: pageCounter)
            let itemListPage = try DataToEntityConverter().convert(data: data, to: ItemListPageDTO.self)
            pageCounter += 1
            
            await MainActor.run {
                itemListPageData = itemListPage
                items.append(contentsOf: itemListPage.items)
            }
        } catch {
            throw error
        }
    }
        
    func requestItemListPageData(pageNumber: Int) async throws -> Data {
        guard let request: URLRequest = API.LookUpItems(pageNumber: pageNumber, itemsPerPage: 100, searchValue: nil).urlRequest else {
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
