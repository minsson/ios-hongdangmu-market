//
//  MySalesHistoryContainerViewModel.swift
//  HongdangmuMarket
//
//  Created by minsson on 2023/04/15.
//

import Foundation

final class MySalesHistoryContainerViewModel: ObservableObject {
    
    @Published var shouldPresentItemAddView: Bool = false
    @Published var items: [Item] = []
    private(set) var hasMoreData = false
    
    private var currentPage = 1
    private let userInformation: UserInformation
    
    init(userInformation: UserInformation) {
        self.userInformation = userInformation
    }
    
}

extension MySalesHistoryContainerViewModel {
    
    func viewNeedsMoreContents() async throws {
        try? await retrieveItems()
    }
        
}

private extension MySalesHistoryContainerViewModel {
    
    func retrieveItems() async throws {
        do {
            let data: Data = try await requestItemListPageData(pageNumber: currentPage)
            let itemListPage = try DataToEntityConverter().convert(data: data, to: ItemListPageDTO.self)
            currentPage += 1
            
            await MainActor.run {
                hasMoreData = itemListPage.hasNext
                items.append(contentsOf: itemListPage.items)
            }
        } catch {
            throw error
        }
    }
        
    func requestItemListPageData(pageNumber: Int) async throws -> Data {
        guard let request: URLRequest = API.LookUpItems(pageNumber: pageNumber, itemsPerPage: 100, searchValue: userInformation.nickname).urlRequest else {
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
