//
//  ErrorLogger.swift
//  HongdangmuMarket
//
//  Created by minsson on 2023/05/31.
//

import Foundation

struct ErrorLogger {
  
  func log<E: HongdangmuErrorProtocol>(error: E?, file: String = #file, function: String = #function, line: Int = #line) {
    guard let error else {
      return
    }
    
    let logMessage = logMessage(error: error, file: file, function: function, line: line)
    print(logMessage)
  }
  
  private func logMessage<E: HongdangmuErrorProtocol>(error: E, file: String, function: String, line: Int) -> String {
    let fileName = file.components(separatedBy: "/").last ?? ""
    let logMessage = """
                        🧩 | Error Log |
                           | Date      | \(Date())
                           | FileName  | \(fileName)
                           | Line      | \(line)
                           | Function  | \(function)
                           | Reason    | \(error.failureReason ?? "wasn't defined")
                      """
    
    return logMessage
  }
  
}
