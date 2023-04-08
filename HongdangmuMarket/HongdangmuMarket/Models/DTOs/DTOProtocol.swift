//
//  DTO.swift
//  HongdangmuMarket
//
//  Created by minsson on 2023/04/09.
//

import Foundation

protocol DTOProtocol: Decodable {
    
    associatedtype Entity
    
    func toEntity() -> Entity
    
}
