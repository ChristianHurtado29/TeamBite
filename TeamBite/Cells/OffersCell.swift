//
//  OfferingsCell.swift
//  TeamBite
//
//  Created by Christian Hurtado on 4/20/20.
//  Copyright © 2020 Christian Hurtado. All rights reserved.
//

import UIKit

class OffersCell: UITableViewCell {
    @IBOutlet weak var venueCell: UILabel!
    @IBOutlet weak var numOfMeals: UILabel!
    @IBOutlet weak var mealsLeft: UILabel!
    
    
    
    public func configureCell(for offer: Offer) {
        venueCell.text = offer.nameOfOffer
        numOfMeals.text = "Total Meals: \(offer.totalMeals.description)"
        mealsLeft.text = "Meals Left: \(offer.remainingMeals.description)"
    }

    
}
