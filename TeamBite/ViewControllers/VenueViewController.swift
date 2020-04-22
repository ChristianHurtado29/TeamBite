//
//  VenueViewController.swift
//  TeamBite
//
//  Created by David Lin on 4/21/20.
//  Copyright © 2020 Christian Hurtado. All rights reserved.
//

import UIKit

class VenueViewController: UIViewController {
    var editState = 0
    
    @IBOutlet weak var offersTableView: UITableView!
    
    private var offers = [Offer]() {
        didSet {
            DispatchQueue.main.async {
                self.offersTableView.reloadData()
            }
        }
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

    }
    @IBAction func editButtonPressed(_ sender: UIButton) {
    }
    
    @IBAction func createOfferButtonPressed(_ sender: UIBarButtonItem) {
    }
    

}
extension VenueViewController: UITableViewDelegate {
    
}

extension VenueViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return offers.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell  = tableView.dequeueReusableCell(withIdentifier: "offerCell", for: indexPath) as? OffersCell else {
            fatalError( "could not downcast to OfferCell")
        }
        
       let offer =  offers[indexPath.row]
        return cell
    }
    
    
}
