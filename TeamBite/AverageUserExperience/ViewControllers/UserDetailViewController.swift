//
//  UserDetailViewController.swift
//  TeamBite
//
//  Created by Margiett Gil on 4/22/20.
//  Copyright © 2020 Christian Hurtado. All rights reserved.
//

import UIKit
import MapKit
import FirebaseFirestore

protocol UserDetailViewControllerDelegate: AnyObject {
    func stateChanged(_ userDetailViewController: UserDetailViewController, _ newState: AppState)
}

class UserDetailViewController: UIViewController {
    
    var selectedVenue: Venue
    var selectedOffers: [Offer] = [] {
        didSet {
            detailView.offersTableView.reloadData()
            if selectedOffers.count == 0 {
                detailView.offersTableView.separatorStyle = .none
                detailView.offersTableView.backgroundView = EmptyView(title: "No Offers", message: "This venue currently has no offerings.")
            } else {
                detailView.offersTableView.separatorColor = UIColor.black
                detailView.offersTableView.separatorStyle = .singleLine
                detailView.offersTableView.backgroundView = nil
            }
        }
    }
    let detailView = UserDetailView()
    
    private var db = DatabaseService()
    private var detailVenues = [Venue]()
    private var currentState: AppState
    private var listener: ListenerRegistration?
    public weak var delegate: UserDetailViewControllerDelegate?
    
    init(_ state: AppState, _ venue: Venue) {
        self.currentState = state
        self.selectedVenue = venue
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("required init(coder:) was not implemented.")
    }
    
    override func loadView() {
        view = detailView
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        updateUI()
        configureOffersTableView()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        listener = Firestore.firestore().collection(DatabaseService.venuesOwnerCollection).document(selectedVenue.venueId).collection(DatabaseService.offersCollection).addSnapshotListener({ [weak self] (snapshot, error) in
            if let error = error {
                self?.showAlert(title: "Date Retrieval Error", message: "Could not retrieve data: \(error.localizedDescription)")
            } else if let snapshot = snapshot {
                let offerName = UserDefaultsHandler.getOfferName() ?? ""
                self?.selectedOffers = snapshot.documents.compactMap{ Offer($0.data()) }.filter{ ($0.remainingMeals > 0 || offerName == $0.nameOfOffer) && ($0.startTime.dateValue() < Date() && $0.endTime.dateValue() > Date()) }
            }
        })
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        listener?.remove()
    }
        
    private func updateUI() {
        view.backgroundColor = #colorLiteral(red: 1, green: 1, blue: 1, alpha: 1)
        navigationItem.title = selectedVenue.name
        navigationItem.rightBarButtonItem = detailView.flagRestaurantButton
        detailView.flagRestaurantButton.target = self
        detailView.flagRestaurantButton.action = #selector(flagRestaurantButtonPressed(_:))
        
        detailView.addressLabel.text = """
        Address:
        \(selectedVenue.address)
        """
        detailView.phoneNumberLabel.text = "Phone: \(selectedVenue.phoneNumber ?? "No phone number")"
    }
    
    private func loadVenue() {
        db.fetchVenues() { [weak self] (result) in
            switch result {
            case .failure(let error):
                DispatchQueue.main.async {
                    self?.showAlert(title: "Loading Error", message: error.localizedDescription)
                }
            case .success(let item):
                self?.detailVenues = item
            }
        }
    }
    
    private func configureOffersTableView() {
        detailView.offersTableView.delegate = self
        detailView.offersTableView.dataSource = self
    }
    
    private func getOffers() {
        DatabaseService.shared.fetchVenueOffers(selectedVenue.venueId) { [weak self] result in
            switch result {
            case .failure(let error):
                self?.showAlert(title: "Error", message: error.localizedDescription)
            case .success(let offers):
                self?.selectedOffers = offers
            }
        }
    }
    
    @objc
    private func flagRestaurantButtonPressed(_ sender: UIBarButtonItem) {
        showOfferAlert("Flag Vendor", "Report this vendor for inappropriate activity?") {
            [unowned self] action in
            self.navigationController?.pushViewController(FlagVendorViewController(self.selectedVenue), animated: true)
        }
    }

}

extension UserDetailViewController: UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return selectedOffers.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let xCell = tableView.dequeueReusableCell(withIdentifier: "offerCell", for: indexPath) as? PatronOfferCell else {
            fatalError("Could not dequeue UITableViewCell as an OffersCell. ")
        }
        
        xCell.configureCell(selectedOffers[indexPath.row])
        return xCell
    }
    
}

extension UserDetailViewController: UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 100
    }
  
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let offerVC = PatronOfferDetailController( selectedOffers[indexPath.row], selectedVenue, currentState)
        offerVC.delegate = self
        navigationController?.pushViewController(offerVC, animated: true)
    }
    
}

extension UserDetailViewController: PatronOfferDetailDelegate {
    func stateChanged(_ patronOfferDetailController: PatronOfferDetailController, _ newState: AppState) {
        currentState = newState
        delegate?.stateChanged(self, newState)
    }
}
