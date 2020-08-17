//
//  Offerings.swift
//  TeamBite
//
//  Created by Christian Hurtado on 4/20/20.
//  Copyright © 2020 Christian Hurtado. All rights reserved.
//

import Foundation
import UIKit

struct Offer {
    let offerId: String
    let nameOfOffer: String
    let totalMeals: Int
    let remainingMeals: Int
    let createdDate: Date
    let startTime: Date  // date picker?
    let endTime: Date // date picker?
    let allergyType: [String]?
    let status: String
    let offerImage: UIImage?
}

    extension Offer {
        init(_ dictionary: [String: Any]) {
            self.offerId = dictionary["offerId"] as? String ?? UUID().uuidString
            self.nameOfOffer = dictionary["nameOfOffer"] as? String ?? "no name"
            self.totalMeals = dictionary["totalMeals"] as? Int ?? 0
            self.remainingMeals = dictionary["remainingMeals"] as? Int ?? 0
            self.createdDate = dictionary["createdDate"] as? Date ?? Date()
            self.startTime = dictionary["startTime"] as? Date ?? Date()
            self.endTime = dictionary["endTime"] as? Date ?? Date()
            self.allergyType = dictionary["allergyType"] as? [String] ?? ["none"]
            self.status = dictionary["status"] as? String ?? "unclaimed"
            self.offerImage = dictionary["offerImage"] as? UIImage ?? UIImage(named: "mic.fill")
        }
    }
    
    
    
    
    


