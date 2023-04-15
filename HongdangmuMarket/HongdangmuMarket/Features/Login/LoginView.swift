//
//  LoginView.swift
//  HongdangmuMarket
//
//  Created by minsson on 2023/04/15.
//

import SwiftUI

struct LoginView: View {
    
    @EnvironmentObject private var userInformation: UserInformation
    
    private let notice = """
    회원가입은 사전에 서버 관리자에게 요청해야 해요. 별도의 회원 정보가 없다면 아래 로그인 버튼을 눌러 기본 ID와 비밀번호로 로그인해주세요.
    """
    
    var body: some View {
        VStack {
            Spacer()
            
            Image("hongdangmu")
                .resizable()
                .scaledToFit()
                .frame(width: UIScreen.main.bounds.width * 0.7)
            
            Spacer()
            
            Text(notice)
                .padding(.vertical)
            
            inputTextField(input: $userInformation.nickname, title: "닉네임")
            
            inputSecureField(input: $userInformation.password, title: "비밀번호")
            
            inputSecureField(input: $userInformation.identifier, title: "Identifier")
                
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
            // TODO: 기능 구현
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
        LoginView()
    }
    
}
