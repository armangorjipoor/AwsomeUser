//
//  Date.swift
//  AwsomeUser
//
//  Created by Arman Gorj on 11/9/1401 AP.
//

import Foundation
extension Date {
    
    var dayInYear: Int {
        let cal = Calendar(identifier: .iso8601)
        return cal.ordinality(of: .day, in: .year, for: self)!
    }
    
    var milliseconds:Double {
        return (self.timeIntervalSince1970 * 1000.0).rounded()
    }
    
    init(milliseconds:Double) {
        self = Date(timeIntervalSince1970: TimeInterval(milliseconds) / 1000)
    }
    
    func getCurrentDate() -> String {
        let todaysDate = Date()
        let dateFormatter = DateFormatter() ;
        dateFormatter.dateFormat = "EEEE, MMM d, yyyy"
        return dateFormatter.string(from: todaysDate)
    }
    
    static var currentDate: String {
        get {
            let dateFormatter = DateFormatter() ;
            dateFormatter.dateFormat = "yyyy-MM-dd'T'HH:mm:ss"
            return dateFormatter.string(from: Date())
        }
    }
    static func getDate_D_M_Y(date: Date) -> String {
        let dateFormatter = DateFormatter() ;
        dateFormatter.dateFormat = "d,  MMMM, yyyy"
        return dateFormatter.string(from: date)
    }
    
    static func getDate(dateString: String)-> Date {
        let dateFormatter = DateFormatter()
//        dateFormatter.dateFormat = "yyyy-MM-dd'T'HH:mm:ss.SSSSZ"
        dateFormatter.dateFormat = "yyyy-MM-dd'T'HH:mm:ss"
        let date = dateFormatter.date(from: dateString) ?? Date()
        
        return date
    }
    
    static func getTime(timeString: String) -> Date {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "HH:mm:ss"
        let date = dateFormatter.date(from: timeString) ?? Date()
        
        return date
    }

}
