//
//  LoginViewModel_Tests.swift
//  HongdangmuMarket_Tests
//
//  Created by minsson on 2023/06/06.
//

import XCTest
@testable import HongdangmuMarket

final class LoginViewModel_Tests: XCTestCase {
  
  private var sut: LoginViewModel!
  private var mockLoginData: LoginDataProtocol!
  private var mockOpenMarketAPIService: OpenMarketAPIServiceProtocol!
  
  override func setUpWithError() throws {
    try super.setUpWithError()
    mockLoginData = MockLoginData.shared
    mockOpenMarketAPIService = MockOpenMarketAPIService()
  }
  
  override func tearDownWithError() throws {
    sut = nil
    mockLoginData = nil
    try super.tearDownWithError()
  }
  
}

extension LoginViewModel_Tests {
  
  func test_LoginViewModel_init_LoginCompletionIsExecuted() async {
    // Given
    let loginCompletionExpectation = expectation(description: "loginCompletion is called")
    sut = LoginViewModel(loginCompletion: {
      loginCompletionExpectation.fulfill()
    })
    
    // When
    sut.loginButtonTapped()
    
    // Then
    await fulfillment(of: [loginCompletionExpectation], timeout: 3)
  }
  
  func test_LoginViewModel_loginButtonTapped_SavesLoginData() {
    // Given
    sut = LoginViewModel(openMarketAPIService: mockOpenMarketAPIService, loginCompletion: { })
    
    // When
    sut.nickname = "MyNickname"
    sut.password = "MyPassword"
    sut.identifier = "MyIdentifier"
    
    sut.loginButtonTapped()
    
    // Then
    XCTAssertEqual(sut.nickname, mockLoginData.nickname)
    XCTAssertEqual(sut.password, mockLoginData.password)
    XCTAssertEqual(sut.identifier, mockLoginData.identifier)
  }
  
}

