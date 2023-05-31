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
    } catch {
      await assign(error)
      ErrorLogger().log(error: self.error, file: file, function: function, line: line)
    }
  }
  
  private func assign(_ error: Error) async {
      await MainActor.run {
          switch error {
          case let error as OpenMarketAPIError:
              self.error = .openMarketAPIServiceError(error)
          case let error as BusinessLogicError:
              self.error = .businessLogicError(error)
          case let error as HongdangmuError:
              self.error = error
          default:
              self.error = .unknownError
          }
      }
  }
  
}
