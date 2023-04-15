//
//  UserInformation.swift
//  HongdangmuMarket
//
//  Created by minsson on 2023/04/15.
//

import Foundation

final class UserInformation: ObservableObject {
    
    @Published var isLoggedIn: Bool = false
    
    @Published var nickname: String = "minsson"
    @Published var password: String = "mn01bv1fm15t0ughb"
    @Published var identifier: String = "0086069b-da91-11ed-8594-df1695979dcc"
    
}
