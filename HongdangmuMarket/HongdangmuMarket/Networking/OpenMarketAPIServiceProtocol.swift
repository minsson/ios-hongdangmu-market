//
//  OpenMarketAPIServiceProtocol.swift
//  HongdangmuMarket
//
//  Created by minsson on 2023/06/04.
//

import UIKit.UIImage

protocol OpenMarketAPIServiceProtocol {
  
    func execute(_ request: URLRequest) async throws -> Data
    func login(nickname: String, password: String, identifier: String)
    func itemListPage(pageNumber: Int, searchValue: String?) async throws -> ItemListPage
    func itemDetail(itemID: String) async throws -> Item
    func deleteItem(id: String) async throws -> Data
    func addItem(data: Data, images: [UIImage]) async throws
    func retrieveRecentlyAddedItem() async throws -> Data
    func editItem(id: String, with data: Data) async throws
    func suggestionWords(for text: String) async -> Data
    func update(stock: Int, of item: Item) async throws
  
}
