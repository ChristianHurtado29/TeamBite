//
//  OfferingsCell.swift
//  TeamBite
//
//  Created by Christian Hurtado on 4/20/20.
//  Copyright © 2020 Christian Hurtado. All rights reserved.
//

import UIKit

protocol OffersCellSelDelegate: AnyObject{
    func cellSelected(_ cell: OffersCell)
}


class OffersCell: UITableViewCell {
    @IBOutlet weak var venueCell: UILabel!
    @IBOutlet weak var numOfMeals: UILabel!
    @IBOutlet weak var mealsLeft: UILabel!
    @IBOutlet weak var mealImage: UIImageView!
    
    public lazy var tapGesture: UITapGestureRecognizer = {
        var tapGest = UITapGestureRecognizer()
        return tapGest
    }()
    
    weak var delegate: OffersCellSelDelegate?
    
    override func layoutSubviews() {
        addGestureRecognizer(tapGesture)
        tapGesture.addTarget(self, action: #selector(gestFunc))
    }
    
    public func configureCell(for offer: Offer) {
        venueCell.text = offer.nameOfOffer
        numOfMeals.text = "Total Meals: \(offer.totalMeals.description)"
        mealsLeft.text = "Meals Left: \(offer.remainingMeals.description)"
    }
    
    @objc
    public func gestFunc(){
        delegate?.cellSelected(self)
    }
    
    
}
