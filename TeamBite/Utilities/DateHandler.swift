//
//  DateHandler.swift
//  TeamBite
//
//  Created by Cameron Rivera on 8/13/20.
//  Copyright © 2020 Christian Hurtado. All rights reserved.
//

import Foundation

struct DateHandler {

    static func todaysDateAsAString() -> String {
        let date = Date()
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "MMMM d,yyyy"
        return dateFormatter.string(from: date)
    }
}
