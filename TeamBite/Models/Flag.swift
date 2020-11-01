//
//  Flag.swift
//  TeamBite
//
//  Created by Cameron Rivera on 10/11/20.
//  Copyright © 2020 Christian Hurtado. All rights reserved.
//

import Foundation

struct Flag {
    var venueName: String
    var venueId: String
    var reason: String
    var explanation: String
    var flagUserId: String
    // Consider making this a TimeInterval (Whatever the firebase equivalent of date is).
    var timeOfIncident: String
    var dateOfIncident: String
    
    init(_ dict: [String: Any]) {
        self.venueName = dict["venueName"] as? String ?? ""
        self.venueId = dict["venueId"] as? String ?? ""
        self.reason = dict["reason"] as? String ?? ""
        self.explanation = dict["explanation"] as? String ?? ""
        self.flagUserId = dict["flagUserId"] as? String ?? ""
        self.timeOfIncident = dict["timeOfIncident"] as? String ?? ""
        self.dateOfIncident = dict["dateOfIncident"] as? String ?? ""
    }
}
