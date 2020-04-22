//
//  VenueCell.swift
//  TeamBite
//
//  Created by Christian Hurtado on 4/20/20.
//  Copyright © 2020 Christian Hurtado. All rights reserved.
//

import UIKit

class VenueCell: UITableViewCell {

    @IBOutlet weak var venueName: UILabel!
    @IBOutlet weak var venueAddress: UILabel!
    @IBOutlet weak var phoneNumber: UILabel!
    
    
    func configureCell(for venue: Venue){
        venueName.text = venue.name
        venueAddress.text = venue.address
        phoneNumber.text = venue.phoneNumber
    }
    
}
