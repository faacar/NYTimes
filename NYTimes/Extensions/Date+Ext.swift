//
//  Date+Ext.swift
//  NYTimes
//
//  Created by Ahmet Acar on 30.01.2021.
//

import Foundation

extension Date {
    
    func convertToMonthYearFormat() -> String {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "MMM dd, YYYY"
        return dateFormatter.string(from: self)
    }
}
