//
//  OfferingsCell.swift
//  TeamBite
//
//  Created by Christian Hurtado on 4/20/20.
//  Copyright © 2020 Christian Hurtado. All rights reserved.
//

import UIKit

class OffersCell: UITableViewCell {
    @IBOutlet weak var offerName: UILabel!
    @IBOutlet weak var totalNumOfMeals: UILabel!
    @IBOutlet weak var totalNumMealsLeft: UILabel!
    
    
    public func configureCell(for offer: Offer) {
        offerName.text = offer.nameOfOffer
        totalNumOfMeals.text = offer.totalMeals.description
        totalNumMealsLeft.text = offer.remainingMeals.description
    }

    
}
