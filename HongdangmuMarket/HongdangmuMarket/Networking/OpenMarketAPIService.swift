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
