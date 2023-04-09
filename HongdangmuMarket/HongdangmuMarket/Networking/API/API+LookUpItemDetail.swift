//
//  API+LookUpItemDetail.swift
//  HongdangmuMarket
//
//  Created by minsson on 2023/04/09.
//

extension API {
    
    struct LookUpItemDetail: OpenMarketAPIRequestGetProtocol {
        
        var productID: String?
        var queryItems: [String: String]?
        
        init(productID: String) {
            self.productID = productID
        }
        
    }
    
}
