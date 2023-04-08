//
//  NetworkManager.swift
//  HongdangmuMarket
//
//  Created by minsson on 2023/04/08.
//

import Foundation

struct NetworkManager {
    
    func execute(_ urlRequest: URLRequest) async throws -> Data {
        do {
            let (data, response) = try await URLSession.shared.data(for: urlRequest)
            
            guard isValidResponse(response) else {
                throw URLError(.badServerResponse)
            }
            return data
        } catch {
            throw error
        }
    }
    
}

private extension NetworkManager {
    
    func isValidResponse(_ response: URLResponse?) -> Bool {
        guard let httpResponse = response as? HTTPURLResponse,
              (200...299).contains(httpResponse.statusCode) else {
            return false
        }
        
        return true
    }
    
}
