//
//  Offerings.swift
//  TeamBite
//
//  Created by Christian Hurtado on 4/20/20.
//  Copyright © 2020 Christian Hurtado. All rights reserved.
//

import Foundation
import FirebaseFirestore

struct Offer {
    let offerId: String
    let nameOfOffer: String
    let totalMeals: Int
    let remainingMeals: Int
    let createdDate: Date
    let startTime: Timestamp  // date picker?
    let endTime: Timestamp // date picker?
    let allergyType: [String]?
    let status: String
    let expectedIds: [String]
}

    extension Offer {
        init(_ dictionary: [String: Any]) {
            self.offerId = dictionary["offerId"] as? String ?? UUID().uuidString
            self.nameOfOffer = dictionary["nameOfOffer"] as? String ?? "no name"
            self.totalMeals = dictionary["totalMeals"] as? Int ?? 0
            self.remainingMeals = dictionary["remainingMeals"] as? Int ?? 0
            self.createdDate = dictionary["createdDate"] as? Date ?? Date()
            self.startTime = dictionary["startTime"] as? Timestamp ?? Timestamp(date: Date())
            self.endTime = dictionary["endTime"] as? Timestamp ?? Timestamp(date: Date())
            self.allergyType = dictionary["allergyType"] as? [String] ?? ["none"]
            self.status = dictionary["status"] as? String ?? "unclaimed"
            self.expectedIds = dictionary["expectedIds"] as? [String] ?? []
        }
    }
    
    
    
    
    


