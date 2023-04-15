//
//  LoginView.swift
//  HongdangmuMarket
//
//  Created by minsson on 2023/04/15.
//

import SwiftUI

struct LoginView: View {
    
    private let notice = """
    회원가입은 사전에 서버 관리자에게 요청해야 합니다. 별도의 회원 정보가 없다면 아래 로그인 버튼을 눌러 기본 ID와 비밀번호로 로그인해주세요.
    """
    
    var body: some View {
        VStack {
            Text(notice)
                .padding(.vertical)
        }
        .padding()
    }
    
}

struct LoginView_Previews: PreviewProvider {
    
    static var previews: some View {
        LoginView()
    }
    
}
