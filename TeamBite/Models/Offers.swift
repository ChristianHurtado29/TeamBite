//
//  Offerings.swift
//  TeamBite
//
//  Created by Christian Hurtado on 4/20/20.
//  Copyright © 2020 Christian Hurtado. All rights reserved.
//

import Foundation

struct Offers: Codable {
    let nameOfOffer: String
    let totalMeals: Int
    let remainingMeals: Int
    let createdDate: Date
    let startTime: Date  // date picker?
    let endTime: Date // date picker?
    let allergyType: [String]?
}

