//
//  VenueCell.swift
//  TeamBite
//
//  Created by Christian Hurtado on 4/20/20.
//  Copyright © 2020 Christian Hurtado. All rights reserved.
//

import UIKit

class VenueCell: UICollectionViewCell {

    @IBOutlet weak var venueName: UILabel!
    @IBOutlet weak var venueAddress: UILabel!
    @IBOutlet weak var phoneNumber: UILabel!
    @IBOutlet weak var venuePic: UIImageView!
    
    func configureCell(for venue: Venue){
        venueName.text = venue.name
        venueAddress.text = venue.address
        phoneNumber.text = venue.phoneNumber
        venuePic.image = UIImage(named: venue.name)
    }
    
}
