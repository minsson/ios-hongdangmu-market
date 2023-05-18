//
//  OpenMarketAPIService.swift
//  HongdangmuMarket
//
//  Created by minsson on 2023/05/18.
//

import Foundation

struct OpenMarketAPIService {
  
  func execute(_ request: URLRequest) async throws -> Data {
    do {
      let data = try await NetworkManager().execute(request)
      return data
    } catch {
      throw error
    }
  }
  
}

// MARK: - LoginViewModel

extension OpenMarketAPIService {
  
  func login(nickname: String, password: String, identifier: String) {
    LoginData.shared.save(nickname: nickname, password: password, identifier: identifier)
  }
  
}

// MARK: - ItemListViewModel

extension OpenMarketAPIService {
  
  func itemListPageData(pageNumber: Int) async throws -> Data {
    guard let request: URLRequest = API.LookUpItems(pageNumber: pageNumber, itemsPerPage: 100, searchValue: nil).urlRequest else {
      throw URLError(.badURL)
    }
    
    let data = try await execute(request)
    return data
  }
  
}

// MARK: - ItemDetailViewModel

extension OpenMarketAPIService {
  
  func itemDetailData(itemID: String) async throws -> Data {
    guard let request: URLRequest = API.LookUpItemDetail(productID: String(itemID)).urlRequest else {
      throw URLError(.badURL)
    }
    
    let data = try await execute(request)
    return data
  }
  
  func itemDetailImageData(for url: String) async throws -> Data {
    guard let url = URL(string: url) else {
      throw URLError(.badURL)
    }
    
    let request = URLRequest(url: url)
    let data = try await execute(request)
    return data
  }
  
}
