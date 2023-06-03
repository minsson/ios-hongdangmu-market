//
//  NetworkManager.swift
//  HongdangmuMarket
//
//  Created by minsson on 2023/04/08.
//

import Foundation

struct NetworkManager {
  
  func execute(_ urlRequest: URLRequest) async throws -> Data {
    let (data, response) = try await URLSession.shared.data(for: urlRequest)
    try validate(urlResponse: response)
    
    return data
  }
  
  func data(from url: URL) async throws -> Data {
    let (data, response) = try await URLSession.shared.data(from: url)
    try validate(urlResponse: response)
    
    return data
  }
  
}

private extension NetworkManager {
  
  func validate(urlResponse: URLResponse) throws {
    guard let httpResponseCode = urlResponse.httpResponseCode() else {
      throw HTTPStatusCodeError.unknown(code: urlResponse.httpResponseCode())
    }
    
    switch httpResponseCode {
    case 100...199:
      throw HTTPStatusCodeError.informational
    case 200...299:
      return
    case 300...399:
      throw HTTPStatusCodeError.redirection
    case 400...499:
      throw HTTPStatusCodeError.clientError(code: httpResponseCode)
    case 500...599:
      throw HTTPStatusCodeError.serverError(code: httpResponseCode)
    default:
      throw HTTPStatusCodeError.unknown(code: httpResponseCode)
    }
  }
  
}

fileprivate extension URLResponse {
  
  func httpResponseCode() -> Int? {
    let httpResponse = self as? HTTPURLResponse
    let httpResponseCode = httpResponse?.statusCode
    
    return httpResponseCode
  }
  
}
