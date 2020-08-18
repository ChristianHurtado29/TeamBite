//
//  DateHandler.swift
//  TeamBite
//
//  Created by Cameron Rivera on 8/13/20.
//  Copyright © 2020 Christian Hurtado. All rights reserved.
//

import Foundation

struct DateHandler {

    static func convertDateToString(_ date: Date, _ showTime: Bool = false) -> String {
        let dateFormatter = DateFormatter()
        if showTime {
            dateFormatter.dateFormat = "MMMM d, yyyy h:mm a"
        } else {
            dateFormatter.dateFormat = "MMMM d, yyyy"
        }
        return dateFormatter.string(from: date)
    }
    
    
    static func calculateNextClaimDate() -> Date {
        let tomorrow = Date(timeIntervalSinceNow: 86000)
        var components = Calendar.current.dateComponents([.day,.year,.month], from: tomorrow)
        components.hour = 6
        let date = Calendar.current.date(from: components) ?? Date()

        return date
    }
}
