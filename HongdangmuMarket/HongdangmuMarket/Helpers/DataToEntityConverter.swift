//
//  JSONEntityConverter.swift
//  HongdangmuMarket
//
//  Created by minsson on 2023/04/09.
//

import Foundation

struct DataToEntityConverter {
    
    func convert<T: DTOProtocol>(data: Data, to entityType: T.Type) throws -> T.Entity {
        do {
            let DTO = try JSONDecoder().decode(T.self, from: data)
            let entity: T.Entity = DTO.toEntity()
            return entity
        } catch {
            throw error
        }
    }
    
}
