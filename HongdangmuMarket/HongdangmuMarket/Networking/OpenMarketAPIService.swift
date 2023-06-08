//
//  OpenMarketAPIService.swift
//  HongdangmuMarket
//
//  Created by minsson on 2023/05/18.
//

import UIKit.UIImage

struct OpenMarketAPIService: OpenMarketAPIServiceProtocol {
  
  private let loginData: LoginDataProtocol
  
  init(loginData: LoginDataProtocol = LoginData.shared) {
    self.loginData = loginData
  }
  
  private func execute(_ request: URLRequest) async throws -> Data {
    let data = try await NetworkManager().execute(request)
    return data
  }
  
}

// MARK: - LoginViewModel

extension OpenMarketAPIService {
  
  func login(nickname: String, password: String, identifier: String) {
    loginData.save(nickname: nickname, password: password, identifier: identifier)
  }
  
}

// MARK: - ItemListViewModel

extension OpenMarketAPIService {
  
  func itemListPage(pageNumber: Int, searchValue: String?) async throws -> ItemListPage {
    guard let request: URLRequest = API.LookUpItems(pageNumber: pageNumber, itemsPerPage: 100, searchValue: searchValue ?? nil).urlRequest else {
      throw OpenMarketAPIError.invalidURLRequest
    }
    
    let data = try await execute(request)
    
    guard let itemListPage: ItemListPage = try? DataToEntityConverter().convert(data: data, to: ItemListPageDTO.self) else {
      throw OpenMarketAPIError.invalidDataReceived
    }
    
    return itemListPage
  }
  
}

// MARK: - ItemDetailViewModel

extension OpenMarketAPIService {
  
  func itemDetail(itemID: String) async throws -> Item {
    guard let request: URLRequest = API.LookUpItemDetail(itemID: String(itemID)).urlRequest else {
      throw OpenMarketAPIError.invalidURLRequest
    }
    
    let data = try await execute(request)
    let item = try DataToEntityConverter().convert(data: data, to: ItemDTO.self)
    
    return item
  }
  
  func deleteItem(id: String) async throws {
    let uriData: Data = try await deletionItemURI(id: id)
    let uriString = String(data: uriData, encoding: .utf8)!
    
    guard let request: URLRequest = API.DeleteItem(itemID: id, deletionItemURI: uriString).urlRequest else {
      throw OpenMarketAPIError.invalidURLRequest
    }
    
    let _ = try await execute(request)
  }
  
  private func deletionItemURI(id: String) async throws -> Data {
    guard let request: URLRequest = API.DeleteItem(itemID: id, deletionItemURI: "").uriRetrievingURLRequest else {
      throw OpenMarketAPIError.invalidURLRequest
    }
    
    let data: Data = try await execute(request)
    
    return data
  }
  
  
}

// MARK: - ItemAddViewModel

extension OpenMarketAPIService {
  
  func addItem(data: Data, images: [UIImage]) async throws {
    let resizedImages = ImageDownsamplingManager().downsample(images: images, withNewWidth: 400)
    
    guard let request: URLRequest = API.AddItem(jsonData: data, images: resizedImages).urlRequest else {
      throw OpenMarketAPIError.invalidURLRequest
    }
    
    let _ = try await execute(request)
  }
  
  func retrieveRecentlyAddedItem() async throws -> Item {
    guard let request: URLRequest = API.LookUpItems(pageNumber: 1, itemsPerPage: 1, searchValue: LoginData.shared.nickname).urlRequest else {
      throw OpenMarketAPIError.invalidURLRequest
    }
    
    let data = try await execute(request)
    let itemListPage = try DataToEntityConverter().convert(data: data, to: ItemListPageDTO.self)
    let items: [Item] = itemListPage.items
    
    guard let item = items.first else {
      throw HongdangmuError.openMarketAPIServiceError(.invalidDataReceived)
    }
    
    return item
  }
  
}

// MARK: ItemEditViewModel

extension OpenMarketAPIService {
  
  func editItem(id: String, with data: Data) async throws {
    guard let request: URLRequest = API.EditItem(itemID: id, with: data).urlRequest else {
      throw OpenMarketAPIError.invalidURLRequest
    }
    
    let _ = try await execute(request)
  }
  
}

// MARK: ItemSearchViewModel

extension OpenMarketAPIService {
  
  /// OpenMarketAPI에는 자주 쓰이는 검색어 DB가 없습니다. 검색어 제안 기능을 구현하기 위해 가짜 네트워킹 메서드를 구현했습니다.
  func suggestionWords(for text: String) async -> [String] {
    let dummyServerResponse: Data = serverFiltersSuggestionWords(for: text)
    try? await Task.sleep(nanoseconds: 100_000_000)
    
    guard let words = try? JSONDecoder().decode([String].self, from: dummyServerResponse) else {
      return []
    }
    
    return words
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
      throw OpenMarketAPIError.invalidURLRequest
    }
    
    let _ = try await execute(request)
  }
  
}
