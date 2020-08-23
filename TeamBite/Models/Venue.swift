//
//  Venue.swift
//  TeamBite
//
//  Created by Christian Hurtado on 4/20/20.
//  Copyright © 2020 Christian Hurtado. All rights reserved.
//

import Foundation

struct Venue: Codable {
    let name: String
    let venueId: String
    let long: Double
    let lat: Double
    let phoneNumber: String?
    let address: String
    let pickupInstructions: String?
    let venueImage: String
}

extension Venue {
    init(_ dictionary: [String: Any]) {
        self.name = dictionary["name"] as? String ?? "No  Venue Name"
        self.venueId = dictionary["userId"] as? String ?? UUID().uuidString
        self.long = dictionary["long"] as? Double ?? 0.00
        self.lat = dictionary["lat"] as? Double ?? 0.00
        self.phoneNumber = dictionary["phoneNumber"] as? String ?? "No Number"
        self.address = dictionary["address"] as? String ?? "No Address"
        self.pickupInstructions = dictionary["pickupInstructions"] as? String ?? "no instructions"
        self.venueImage = dictionary["venueImage"] as? String ?? "no image"
    }
}
