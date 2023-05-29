//
//  OpenMarketAPIService.swift
//  HongdangmuMarket
//
//  Created by minsson on 2023/05/18.
//

import UIKit.UIImage

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
  
  func itemListPageData(pageNumber: Int, searchValue: String?) async throws -> Data {
    guard let request: URLRequest = API.LookUpItems(pageNumber: pageNumber, itemsPerPage: 100, searchValue: searchValue ?? nil).urlRequest else {
      throw URLError(.badURL)
    }
    
    let data = try await execute(request)
    return data
  }
  
}

// MARK: - ItemDetailViewModel

extension OpenMarketAPIService {
  
  func itemDetailData(itemID: String) async throws -> Data {
    guard let request: URLRequest = API.LookUpItemDetail(itemID: String(itemID)).urlRequest else {
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
  
  func deleteItem(id: String) async throws -> Data {
    let uriData: Data = try await deletionItemURI(id: id)
    let uriString = String(data: uriData, encoding: .utf8)!
    
    guard let request: URLRequest = API.DeleteItem(itemID: id, deletionItemURI: uriString).urlRequest else {
      throw URLError(.badURL)
    }
    
    let data: Data = try await execute(request)
    return data
  }
  
  private func deletionItemURI(id: String) async throws -> Data {
    guard let request: URLRequest = API.DeleteItem(itemID: id, deletionItemURI: "").uriRetrievingURLRequest else {
      throw URLError(.badURL)
    }
    
    let data: Data = try await execute(request)
    return data
  }
  
  
}

// MARK: - ItemAddViewModel

extension OpenMarketAPIService {
  
  func addItem(data: Data, images: [UIImage]) async throws {
    let resizedImages = ImageManager().resize(images: images)
    
    guard let request: URLRequest = API.AddItem(jsonData: data, images: resizedImages).urlRequest else {
      throw URLError(.badURL)
    }
    
    let _ = try await execute(request)
  }
  
  func retrieveRecentlyAddedItem() async throws -> Data {
    guard let request: URLRequest = API.LookUpItems(pageNumber: 1, itemsPerPage: 1, searchValue: LoginData.shared.nickname).urlRequest else {
      throw URLError(.badURL)
    }
    
    let data = try await execute(request)
    return data
  }
  
}

// MARK: ItemEditViewModel

extension OpenMarketAPIService {
  
  func editItem(id: String, with data: Data) async throws {
    guard let request: URLRequest = API.EditItem(itemID: id, with: data).urlRequest else {
      return
    }
    
    let _ = try await execute(request)
  }
  
}

// MARK: ItemSearchViewModel

extension OpenMarketAPIService {
  
  /// OpenMarketAPI에는 자주 쓰이는 검색어 DB가 없습니다. 검색어 제안 기능을 구현하기 위해 가짜 네트워킹 메서드를 구현했습니다.
  func suggestionWords(for text: String) async -> Data {
    let dummyServerResponse: Data = serverFiltersSuggestionWords(for: text)
    try? await Task.sleep(nanoseconds: 100_000_000)
    
    return dummyServerResponse
  }
  
  /// 서버 쪽에서 작업해줄 것으로 예상하지만, 현재 사용중인 OpenMarketAPI에서 제공하지 않는 기능이므로 임시로 서버의 response를 구현했습니다.
  private func serverFiltersSuggestionWords(for text: String) -> Data {
    let dummyServerDatabase: [String] = ["애플", "아이폰", "Apple", "아이패드", "노트북", "맥북"]
    var response: [String] = []
    
    if text.isEmpty {
      response = []
    } else {
      response = dummyServerDatabase.filter { $0.hasPrefix(text) }
    }
    
    let data: Data = try! JSONEncoder().encode(response)
    
    return data
  }
  
}

// MARK: - MySalesHistoryContainerViewModel

extension OpenMarketAPIService {
  
  func update(stock: Int, of item: Item) async throws {
    let addRequestItemDTO = item.toDTO().toAddRequestItemDTO()
    let data = try? JSONEncoder().encode(addRequestItemDTO)
    
    guard let request = API.EditItem(itemID: item.id, with: data).urlRequest else {
      return
    }
    
    let _ = try await execute(request)
  }
  
}
