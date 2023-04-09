//
//  OpenMarketAPIRequestPostProtocol.swift
//  HongdangmuMarket
//
//  Created by minsson on 2023/04/09.
//

import Foundation

protocol OpenMarketAPIRequestPostProtocol: OpenMarketAPIRequestProtocol, MultipartFormDataHandlingProtocol { }

extension OpenMarketAPIRequestPostProtocol {
    
    var url: URL? {
        let urlComponents = URLComponents(string: urlHost + urlPath)
        
        return urlComponents?.url
    }
    
    var urlRequest: URLRequest? {
        guard let url = url else {
            return nil
        }
        
        var request = URLRequest(url: url)
        request.httpMethod = httpMethod
        request.setValue("7184295e-4aa1-11ed-a200-354cb82ae52e", forHTTPHeaderField: "identifier")
        request.setValue("multipart/form-data; boundary=" + boundary, forHTTPHeaderField: "Content-type")
        request.httpBody = multipartFormBody
        return request
    }
    
}
