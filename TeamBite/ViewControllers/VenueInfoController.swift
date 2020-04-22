//
//  VenueInfoController.swift
//  TeamBite
//
//  Created by Christian Hurtado on 4/20/20.
//  Copyright © 2020 Christian Hurtado. All rights reserved.
//

import UIKit
import FirebaseFirestore
import FirebaseAuth

class VenueInfoController: UIViewController {
    
    @IBOutlet weak var venueName: UILabel!
    @IBOutlet weak var venuePhoto: UIImageView!
    @IBOutlet weak var venueAddress: UILabel!
    @IBOutlet weak var venuePhone: UILabel!
    @IBOutlet weak var venueHours: UILabel!
    
    private var venue: Venue!
    private var listener: ListenerRegistration?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configureDetails(venue: venue)
    }
    
    func configureDetails(venue: Venue){
        navigationItem.title = "Welcome to, \(venue.name)"
        venuePhoto.image = UIImage(systemName: "bag.fill")
        venueName.text = venue.name
        venuePhone.text = venue.phoneNumber
        venueHours.text = """
        pickup begins at: \(venue.startTime!)
        pickup ends at: \(venue.endTime!)
        """
    }
    
    
    
    
}
