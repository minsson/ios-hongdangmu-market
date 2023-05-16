//
//  LoginViewModel.swift
//  HongdangmuMarket
//
//  Created by minsson on 2023/05/16.
//

import Foundation

final class LoginViewModel: ObservableObject {
  
  @Published var nickname: String = "minsson"
  @Published var password: String = "mn01bv1fm15t0ughb"
  @Published var identifier: String = "0086069b-da91-11ed-8594-df1695979dcc"
  
  let notice = """
    회원가입은 사전에 서버 관리자에게 요청해야 해요. 별도의 회원 정보가 없다면 아래 로그인 버튼을 눌러 기본 ID와 비밀번호로 로그인해주세요.
    """
  
  let loginCompletion: () -> Void
  
  init(loginCompletion: @escaping () -> Void) {
    self.loginCompletion = loginCompletion
  }
  
  func loginButtonTapped() {
    Temp.shared.save(nickname: nickname, password: password, identifier: identifier)
    // TODO: 곧 구현할 로그인 정보 싱글톤 객체에 데이터 전달
    loginCompletion()
  }
  
}
