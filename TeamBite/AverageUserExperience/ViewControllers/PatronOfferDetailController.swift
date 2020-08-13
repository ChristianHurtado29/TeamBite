//
//  PatronOfferDetailController.swift
//  TeamBite
//
//  Created by Cameron Rivera on 7/27/20.
//  Copyright © 2020 Christian Hurtado. All rights reserved.
//

import UIKit
import MapKit
import FirebaseAuth

protocol PatronOfferDetailDelegate: AnyObject {
    func stateChanged(_ patronOfferDetailController: PatronOfferDetailController, _ newState: AppState)
}

// Disable claim offer from other offers.
// Move the mapView to this page. 

class PatronOfferDetailController: UIViewController {

    private let detailView = PatronOfferDetailView()
    private var mealState = MealStatus.unclaimed
    private var currentState: AppState
    private let currentOffer: Offer
    private let currentVenue: Venue
    private let currentUserId: String
    private let coreLocationManager = CoreLocationManager()
    
    public weak var delegate: PatronOfferDetailDelegate?
    
    init(_ offer: Offer, _ venue: Venue, _ state: AppState) {
        let userId = Auth.auth().currentUser?.uid ?? ""
        self.currentUserId = userId
        self.currentState = state
        self.currentOffer = offer
        self.currentVenue = venue
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("required init?(coder:) has not been implemented.")
    }
    
    override func loadView() {
        view = detailView
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setUpUI()
        configureState()
        configureMapView()
    }
    
    private func setUpUI() {
        navigationItem.title = currentOffer.nameOfOffer
        navigationController?.navigationBar.tintColor = #colorLiteral(red: 0.8549019694, green: 0.250980407, blue: 0.4784313738, alpha: 1)
        detailView.backgroundColor = UIColor.systemBackground
        
        detailView.claimOfferButton.addTarget(self, action: #selector(claimOfferButtonPressed(_:)), for: .touchUpInside)
        detailView.forfeitOfferButton.addTarget(self, action: #selector(forfeitOfferButtonPressed(_:)), for: .touchUpInside)
        detailView.getDirectionsButton.addTarget(self, action: #selector(getDirectionsButtonPressed(_:)), for: .touchUpInside)
    }
    
    private func configureMapView() {
        let annotation = coreLocationManager.createAnnotation(CLLocationCoordinate2D(latitude: currentVenue.lat, longitude: currentVenue.long), currentVenue.name)
        detailView.mapView.addAnnotation(annotation)
        detailView.mapView.showAnnotations([annotation], animated: true)
    }
    
    private func configureState() {
        if currentState == AppState.offerClaimed{
            if UserDefaultsHandler.getOfferName() ?? "" == currentOffer.nameOfOffer {
                detailView.configureClaimedCurrentOfferState(currentOffer.nameOfOffer)
            } else {
                detailView.configureOfferClaimedState()
            }
        } else {
            detailView.configureUnclaimedOfferState()
        }
    }
    
    @objc
    private func claimOfferButtonPressed(_ sender: UIButton) {
        showOfferAlert("Claim Offer", "You are about to claim this meal. If you claim this meal, you will not be able to claim another. Are you sure you would like to claim this meal?") { [weak self] (action) in
            self?.claimedButtonUpdates()
        }
    }
    
    private func claimedButtonUpdates() {
        DatabaseService.shared.claimOffer(currentVenue.venueId, currentOffer.offerId) { [weak self] result in
            switch result {
            case .failure(let error):
                self?.showAlert(title: "Error", message: "Could not successfully claim offer: \(error.localizedDescription)") { [weak self] alertAction in
                    self?.navigationController?.popViewController(animated: true)
                }
            case .success:
                self?.showAlert(title: "Success", message: "Successfully claimed offer.")
                self?.setClaimedState()
            }
        }
        delegate?.stateChanged(self, AppState.offerClaimed)
    }
    
    private func setClaimedState() {
        detailView.claimOfferButton.alpha = 0.0
        detailView.forfeitOfferButton.alpha = 1.0
        detailView.willGenerateCodeLabel.isHidden = true
        detailView.qrCodeImageView.image = QRCodeHandler.generateQRCode(from: currentOffer.nameOfOffer)
        DatabaseService.shared.updateStatus(currentUserId, "claimed") { [weak self] result in
            switch result {
            case .failure(let error):
                self?.showAlert(title: "Update Error", message: "Could not update claim status: \(error.localizedDescription)")
            case .success:
                break
            }
        }
        delegate?.stateChanged(self, AppState.offerClaimed)
        UserDefaultsHandler.setStateToClaimed()
        UserDefaultsHandler.saveOfferName(currentOffer.nameOfOffer)
    }
    
    @objc
    private func forfeitOfferButtonPressed(_ sender: UIButton) {
        showOfferAlert("Forfeit Offer", "You are about to forfeit your claim to this meal. If you forfeit this meal, you will not be able to claim another until tomorrow. Are you sure that you would like to forfeit this meal?") { [weak self] action in
            self?.forfeitButtonUpdates()
        }
    }
    
    private func forfeitButtonUpdates() {
        detailView.claimOfferButton.alpha = 1.0
        detailView.claimOfferButton.isUserInteractionEnabled = false
        detailView.forfeitOfferButton.alpha = 0.0
        UserDefaultsHandler.resetOfferName()
        DatabaseService.shared.forfeitOffer(currentVenue.venueId, currentOffer.offerId) {
            [weak self] result in
            switch result {
            case .failure(let error):
                self?.showAlert(title: "Error", message: "Could not forfeit error: \(error.localizedDescription)")
            case .success:
                self?.showAlert(title: "Success", message: "Meal successfully forfeited. You'll be able to claim another meal tomorrow.")
            }
        }
        detailView.configureOfferClaimedState()
    }
    
    @objc
    private func getDirectionsButtonPressed(_ sender: UIButton) {
        let getDirectionsVC = GetDirectionsController(currentVenue)
        present(getDirectionsVC, animated: true)
    }

}
