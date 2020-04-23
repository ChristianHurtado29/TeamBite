//
//  VenueViewController.swift
//  TeamBite
//
//  Created by David Lin on 4/21/20.
//  Copyright © 2020 Christian Hurtado. All rights reserved.
//

import UIKit
import FirebaseAuth
import FirebaseFirestore

class VenueViewController: UIViewController {
    var editState = 0
    
    private let db = Firestore.firestore()
    private var listener: ListenerRegistration?
    
    @IBOutlet weak var cancelButton: UIButton!
    @IBOutlet weak var venueAddressLabel: UILabel!
    @IBOutlet weak var venueContactLabel: UILabel!
    @IBOutlet weak var offersTableView: UITableView!
    @IBOutlet weak var editAddressTextField: UITextField!
    @IBOutlet weak var editPhoneNumberTextField: UITextField!
    @IBOutlet weak var editButton: UIButton!
    @IBOutlet weak var saveButton: UIButton!
    
    private var offers = [Offer]() {
        didSet {
            DispatchQueue.main.async {
                self.offersTableView.reloadData()
            }
        }
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        fetchOffers()
        // Edit State
        if editState == 0 {
            editButton.isHidden = false
            cancelButton.isHidden = true
            saveButton.isHidden = true
            editAddressTextField.isHidden = true
            editPhoneNumberTextField.isHidden = true
        }
        
        offersTableView.delegate = self
        offersTableView.dataSource = self
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        self.navigationController?.setNavigationBarHidden(true, animated: true)
    }
    
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(true)
        guard let user = Auth.auth().currentUser else { return }
//        listener = Firestore.firestore().collection(DatabaseService.venuesOwnerCollection).document(user.uid).addSnapshotListener({ [weak self] (snapshot, error) in
//            if let error = error {
//                DispatchQueue.main.async {
//                    self?.showAlert(title: "Try again later", message: "\(error.localizedDescription)")
//                }
//            } else if let snapshot = snapshot {
//                let offers = snapshot
//                self?.offers = offers.data()
//            }
//        })
    }
    
    func fetchOffers(){
        guard let user = Auth.auth().currentUser else { return }
        DatabaseService.shared.fetchVenueOffers() { [weak self] (result) in
            switch result {
            case .failure(let error):
                DispatchQueue.main.async {
                    self?.showAlert(title: "Failed to get offers", message: "oops! \(error)")
                }
            case .success(let offers):
                DispatchQueue.main.async {
                    self?.offers = offers
                    print(offers)
                }
            }
            
        }
    }
    
    
    @IBAction func editButtonPressed(_ sender: UIButton) {
        editState = 1
        saveButton.isHidden = false
        cancelButton.isHidden = false
        editPhoneNumberTextField.isHidden = false
        editAddressTextField.isHidden = false
        venueAddressLabel.alpha = 0.0
        venueContactLabel.alpha = 0.0
        editButton.isHidden = true
    }
    
    
    @IBAction func saveButtonPressed(_ sender: UIButton) {
        editState = 0
        guard let address = editAddressTextField.text,
            !address.isEmpty else { return }
        
        guard let phone = editPhoneNumberTextField.text, !phone.isEmpty else { return }
        
        self.updateDatabaseUser(address: address, phoneNumber: phone)
        venueAddressLabel.isHidden = false
        venueContactLabel.isHidden = false
    }
    
    
    private func updateDatabaseUser(address: String, phoneNumber: String) {
        
        DatabaseService.shared.updateVenue(address: address, phoneNumber: phoneNumber) { (result) in
            switch result {
            case .failure(let error):
                print("failed to update db user: \(error.localizedDescription)")
            case .success:
                print("successfully updated db user")
            }
        }
    }
    
    
    
    @IBAction func cancelButtonPressed(_ sender: UIButton) {
        editState = 0
        editButton.isHidden = false
        cancelButton.isHidden = true
        saveButton.isHidden = true
        editAddressTextField.isHidden = true
        editPhoneNumberTextField.isHidden = true
        venueAddressLabel.alpha = 1.0
        venueContactLabel.alpha = 1.0
    }
    
    
    @IBAction func createOfferButtonPressed(_ sender: UIBarButtonItem) {
        let storyboard =  UIStoryboard(name: "Venues", bundle: nil)
        guard let vc = storyboard.instantiateViewController(identifier: "CreateOffersViewController") as? CreateOffersViewController else { fatalError()}
        
        
        
//        guard let vc = storyboard.instantiateViewController(Identifier: "CreateOffersViewController") as? CreateOffersViewController else {fatalError("\()")}
        
        self.present(vc, animated: true, completion: nil)
        
    }
    
    
}


extension VenueViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 80
    }
}

extension VenueViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return offers.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell  = tableView.dequeueReusableCell(withIdentifier: "offersCell", for: indexPath) as? OffersCell else {
            fatalError( "could not downcast to OfferCell")
        }
        let offer =  offers[indexPath.row]
        cell.configureCell(for: offer)
        return cell
    }
    
    
}
