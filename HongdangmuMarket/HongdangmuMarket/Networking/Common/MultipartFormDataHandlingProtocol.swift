//
//  MultipartFormDataHandlingProtocol.swift
//  HongdangmuMarket
//
//  Created by minsson on 2023/04/09.
//

import SwiftUI

protocol MultipartFormDataHandlingProtocol {
  
  var jsonData: Data? { get }
  var boundary: String { get }
  var images: [UIImage] { get }
  
}

extension MultipartFormDataHandlingProtocol {
  
  var multipartFormBody: Data? {
    var body = Data()
    let lineBreak = "\r\n"
    
    guard let jsonData = jsonData else {
      return nil
    }
    
    body.append("--\(boundary + lineBreak)")
    body.append("Content-Disposition: form-data; name=\"params\"\(lineBreak + lineBreak)")
    body.append(jsonData)
    body.append("\(lineBreak)")
    
    images.forEach { image in
      body.append("--\(boundary + lineBreak)")
      body.append("Content-Disposition: form-data; name=\"images\"; filename=\"\(UUID().uuidString).jpg\"\(lineBreak)")
      body.append("Content-Type: image/jpeg\(lineBreak + lineBreak)")
      
      guard let imageData = image.jpegData(compressionQuality: 0.5) else {
        return
      }
      
      body.append(imageData)
      body.append(lineBreak)
    }
    
    body.append("--\(boundary)--\(lineBreak)")
    
    return body
  }
  
}

fileprivate extension Data {
  
  mutating func append(_ string: String) {
    if let data = string.data(using: .utf8) {
      self.append(data)
    }
  }
  
}
