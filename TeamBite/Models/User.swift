//
//  Users.swift
//  TeamBite
//
//  Created by David Lin on 4/21/20.
//  Copyright © 2020 Christian Hurtado. All rights reserved.
//

import Foundation
import FirebaseFirestore

struct User {
    let userId: String
    let phoneNumber: String
    let allergies: [String]
    let claimStatus: String
    let timeOfNextClaim: Timestamp
    let qrCodeScanned: Bool
}

extension User {
    init(_ dictionary: [String: Any]) {
        self.userId = dictionary["userId"] as? String ?? UUID().uuidString
        self.phoneNumber = dictionary["phoneNumber"] as? String ?? "No Number"
        self.allergies = dictionary["allergies"] as? [String] ?? ["No Allergies"]
        self.claimStatus = dictionary["claimStatus"] as? String ?? "unclaimed"
        self.timeOfNextClaim = dictionary["timeOfNextClaim"] as? Timestamp ?? Timestamp(date: Date())
        self.qrCodeScanned = dictionary["qrCodeScanned"] as? Bool ?? false
    }
}
