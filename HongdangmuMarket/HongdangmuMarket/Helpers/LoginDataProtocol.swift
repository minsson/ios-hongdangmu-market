//
//  LoginDataProtocol.swift
//  HongdangmuMarket
//
//  Created by minsson on 2023/06/06.
//

protocol LoginDataProtocol {
  
  var nickname: String { get }
  var password: String { get }
  var identifier: String { get }
  
  func save(nickname: String, password: String, identifier: String)
  
}
