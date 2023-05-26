//
//  DateCalculator.swift
//  HongdangmuMarket
//
//  Created by minsson on 2023/04/09.
//

import Foundation

struct DateCalculator {
  
  private let dateFormatter = DateFormatter()
  
  func dateDifferenceToToday(from targetDate: Date) -> Int {
    let dateDifference = dateDifference(fromDate: targetDate, toDate: Date.now)
    return dateDifference
  }
  
  func stringToDate(_ dateString: String, usingFormat formatString: String) -> Date {
    dateFormatter.timeZone = TimeZone.autoupdatingCurrent
    dateFormatter.dateFormat = formatString
    guard let date = dateFormatter.date(from: dateString) else {
      // TODO: 에러 처리
      fatalError("Invalid date string format")
    }
    return date
  }
  
  func dateToString(_ date: Date, usingFormat formatString: String) -> String {
    dateFormatter.timeZone = TimeZone.autoupdatingCurrent
    dateFormatter.dateFormat = formatString
    let dateString = dateFormatter.string(from: date)
    return dateString
  }
  
}

private extension DateCalculator {
  
  func dateDifference(fromDate: Date, toDate: Date) -> Int {
    let calendar = Calendar.current
    guard let dateDifference = calendar.dateComponents([.day], from: fromDate, to: Date()).day else {
      // TODO: 에러 처리
      fatalError("Invalid date string format")
    }
    
    return dateDifference
  }
  
}
