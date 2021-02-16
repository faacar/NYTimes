//
//  String+Ext.swift
//  NYTimes
//
//  Created by Ahmet Acar on 30.01.2021.
//

import Foundation

extension String {
    
    func convertToNewsDate(stringDate: String) -> Date? {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = stringDate
        dateFormatter.locale = Locale(identifier: "en")
        dateFormatter.timeZone = .current
        
        return dateFormatter.date(from: self)
    }
    
    func convertToDisplayFormat() -> String {
        
        if let date = self.convertToNewsDate(stringDate: "yyyy-MM-dd'T'HH:mm:ssZ") {
            return date.convertToMonthYearFormat()
        } else if let date = self.convertToNewsDate(stringDate: "yyyy-MM-dd HH:mm:ss") {
            return date.convertToMonthYearFormat()
        } else {
            return "N/A"
        }
        
        /*
        guard let date = self.convertToNewsDate(stringDate: "yyyy-MM-dd'T'HH:mm:ssZ") else { return "N/A"}
        return date.convertToMonthYearFormat()
         */
    }
}
