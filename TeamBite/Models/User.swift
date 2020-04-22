//
//  Users.swift
//  TeamBite
//
//  Created by David Lin on 4/21/20.
//  Copyright © 2020 Christian Hurtado. All rights reserved.
//

import Foundation

struct User: Codable {
    let userId: String
    let phoneNumber: String
    let allergies: [String]
}

extension User {
    init(_ dictionary: [String: Any]) {
        self.userId = dictionary["userId"] as? String ?? UUID().uuidString
        self.phoneNumber = dictionary["phoneNumber"] as? String ?? "No Number"
        self.allergies = dictionary["allergies"] as? [String] ?? ["No Allergies"]
    }
}
