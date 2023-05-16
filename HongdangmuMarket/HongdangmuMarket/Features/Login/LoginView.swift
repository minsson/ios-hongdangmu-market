//
//  LoginView.swift
//  HongdangmuMarket
//
//  Created by minsson on 2023/04/15.
//

import SwiftUI

struct LoginView: View {
  
  @StateObject private var viewModel: LoginViewModel
  
  init(loginCompletion: @escaping () -> Void) {
    _viewModel = StateObject(wrappedValue: LoginViewModel(loginCompletion: loginCompletion))
  }
  
  var body: some View {
    VStack {
      Spacer()
      
      Image("hongdangmu")
        .resizable()
        .scaledToFit()
        .frame(width: UIScreen.main.bounds.width * 0.7)
      
      Spacer()
      
      Text(viewModel.notice)
        .padding(.vertical)
      
      inputTextField(input: $viewModel.nickname, title: "닉네임")
      
      inputSecureField(input: $viewModel.password, title: "비밀번호")
      
      inputSecureField(input: $viewModel.identifier, title: "Identifier")
      
      Spacer()
      
      loginButton
    }
    .padding()
  }
  
}

private extension LoginView {
  
  func inputTextField(input: Binding<String>, title: String) -> some View {
    HStack(alignment: .bottom) {
      ZStack {
        RoundedRectangle(cornerRadius: 4)
          .fill(Color(UIColor.systemGray5))
        
        Text(title)
      }
      .frame(width: 100, height: 50)
      
      VStack {
        TextField(text: input) {
          
        }
        .padding(.bottom, 4)
        
        Divider()
      }
    }
  }
  
  func inputSecureField(input: Binding<String>, title: String) -> some View {
    HStack(alignment: .bottom) {
      ZStack {
        RoundedRectangle(cornerRadius: 4)
          .fill(Color(UIColor.systemGray5))
        
        Text(title)
      }
      .frame(width: 100, height: 50)
      
      VStack {
        SecureField(text: input) {
          
        }
        .padding(.bottom, 4)
        
        Divider()
      }
    }
  }
  
  var loginButton: some View {
    Button {
      // OpenMarketAPI에 유효한 ID/비밀번호인지 검증하는 기능이 없습니다.
      // 우선 로그인 버튼을 누르면 무조건 로그인 되도록 구현했습니다.
      viewModel.loginButtonTapped()
    } label: {
      ZStack {
        RoundedRectangle(cornerRadius: 4)
          .fill(.orange)
        
        Text("로그인")
          .bold()
          .foregroundColor(.white)
      }
      .frame(height: 50)
      .frame(maxWidth: .infinity)
    }
    .padding(.vertical)
  }
  
}

struct LoginView_Previews: PreviewProvider {
  
  static var previews: some View {
    LoginView {
      
    }
  }
  
}
