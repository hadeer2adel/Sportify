//
//  DateConverter.swift
//  Sportify
//
//  Created by Hadeer Adel Ahmed on 20/05/2024.
//

import Foundation

class DateConverter{
    
    func getCurrentDate() -> String {
        let currentDate = Date()
        
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy-MM-dd"
        let date = dateFormatter.string(from: currentDate)
        
        return date
    }
    
    func getOtherDate(lastYear: Bool) -> String {
        let currentDate = Date()
        let calendar = Calendar.current
        
        var value = 1
        if lastYear{
            value = -1
        }
        
        if let newYear = calendar.date(byAdding: .year, value: value, to: currentDate) {
            let dateFormatter = DateFormatter()
            dateFormatter.dateFormat = "yyyy-MM-dd"
            let date = dateFormatter.string(from: newYear)
            return date

        } else {
            print("Error: Couldn't calculate date from one year ago.")
            return ""
        }
    }
}
