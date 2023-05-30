//
//  ViewModelErrorHandlingProtocol.swift
//  HongdangmuMarket
//
//  Created by minsson on 2023/05/30.
//

import Foundation

protocol ViewModelErrorHandlingProtocol: AnyObject {
  
  var error: HongdangmuError? { get set }
  
}

extension ViewModelErrorHandlingProtocol {
  
  func handleError(_ action: () async throws -> Void, file: String = #file, function: String = #function, line: Int = #line) async {
    do {
      try await action()
    } catch let error as OpenMarketAPIError {
      self.error = HongdangmuError.openMarketAPIServiceError(error)
    } catch let error as BusinessLogicError {
      self.error = HongdangmuError.businessLogicError(error)
    } catch {
      self.error = HongdangmuError.unknownError
    }
  }
  
}

