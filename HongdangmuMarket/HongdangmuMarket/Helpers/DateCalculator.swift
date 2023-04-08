//
//  DateCalculator.swift
//  HongdangmuMarket
//
//  Created by minsson on 2023/04/09.
//

import Foundation

struct DateCalculator {
    
    private let dateFormatter = DateFormatter()
    
    func dateDifferenceToToday(from targetDateString: String) -> Int {
        let targetDate = stringToDate(targetDateString, usingFormat: "yyyy-MM-dd'T'HH:mm:ss")
        let dateDifference = dateDifference(fromDate: targetDate, toDate: Date())
        return dateDifference
    }
    
}

private extension DateCalculator {
    
    func stringToDate(_ dateString: String, usingFormat formatString: String) -> Date {
        dateFormatter.timeZone = TimeZone.autoupdatingCurrent
        dateFormatter.dateFormat = formatString
        guard let date = dateFormatter.date(from: dateString) else {
            // TODO: 에러 처리
            fatalError("Invalid date string format")
        }
        return date
    }
    
    func dateDifference(fromDate: Date, toDate: Date) -> Int {
        let calendar = Calendar.current
        guard let dateDifference = calendar.dateComponents([.day], from: fromDate, to: Date()).day else {
            // TODO: 에러 처리
            fatalError("Invalid date string format")
        }
        
        return dateDifference
    }

}
