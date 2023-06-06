//
//  LoginData.swift
//  HongdangmuMarket
//
//  Created by minsson on 2023/05/17.
//

final class LoginData: LoginDataProtocol {
  
  static let shared = LoginData()
  
  private init() { }
  
  private(set) var nickname: String = ""
  private(set) var password: String = ""
  private(set) var identifier: String = ""
  
  func save(nickname: String, password: String, identifier: String) {
    self.nickname = nickname
    self.password = password
    self.identifier = identifier
  }
  
}
