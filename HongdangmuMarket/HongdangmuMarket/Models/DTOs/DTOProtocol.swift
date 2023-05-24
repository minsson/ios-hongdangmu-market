//
//  DTO.swift
//  HongdangmuMarket
//
//  Created by minsson on 2023/04/09.
//

protocol DTOProtocol: Decodable {
  
  associatedtype Entity
  
  func toEntity() -> Entity
  
}
