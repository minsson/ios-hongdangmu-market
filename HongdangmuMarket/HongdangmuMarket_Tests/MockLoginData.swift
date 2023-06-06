//
//  MockLoginData.swift
//  HongdangmuMarket_Tests
//
//  Created by minsson on 2023/06/06.
//

import Foundation
@testable import HongdangmuMarket

final class MockLoginData: LoginDataProtocol {
  
  static var shared: LoginDataProtocol = MockLoginData()
  
  private(set) var nickname: String = ""
  private(set) var password: String = ""
  private(set) var identifier: String = ""
  
  private init() { }
  
}

extension MockLoginData {
  
  func save(nickname: String, password: String, identifier: String) {
    self.nickname = nickname
    self.password = password
    self.identifier = identifier
  }
  
  func reset() {
    MockLoginData.shared = MockLoginData()
  }
  
}

