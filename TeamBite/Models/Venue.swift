//
//  Venue.swift
//  TeamBite
//
//  Created by Christian Hurtado on 4/20/20.
//  Copyright © 2020 Christian Hurtado. All rights reserved.
//

import Foundation

struct Venue: Codable {
    var name: String
    var venueId: String
    var long: Double
    var lat: Double
    var phoneNumber: String?
    var address: String
    var city: String
    var state: String
    var street: String
    var zip: String
    var pickupInstructions: String?
    var venueImage: String
}

extension Venue {
    init(_ dictionary: [String: Any]) {
        self.name = dictionary["name"] as? String ?? "No  Venue Name"
        self.venueId = dictionary["userId"] as? String ?? UUID().uuidString
        self.long = dictionary["long"] as? Double ?? 0.00
        self.lat = dictionary["lat"] as? Double ?? 0.00
        self.phoneNumber = dictionary["phoneNumber"] as? String ?? "No Number"
        self.address = dictionary["address"] as? String ?? "No Address"
        self.city = dictionary["city"] as? String ?? "No City"
        self.state = dictionary["state"] as? String ?? "No state"
        self.street = dictionary["street"] as? String ?? "No street"
        self.zip = dictionary["zip"] as? String ?? "No zip"
        self.pickupInstructions = dictionary["pickupInstructions"] as? String ?? "no instructions"
        self.venueImage = dictionary["venueImage"] as? String ?? "no image"
    }
}
