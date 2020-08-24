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
import FirebaseFirestore

protocol PatronOfferDetailDelegate: AnyObject {
    func stateChanged(_ patronOfferDetailController: PatronOfferDetailController, _ newState: AppState)
}

// Disable claim offer from other offers.
// Move the mapView to this page. 

class PatronOfferDetailController: UIViewController {

    private var mealState = MealStatus.unclaimed
    private var currentState: AppState
    private var listener: ListenerRegistration?
    private let currentOffer: Offer
    private let currentVenue: Venue
    private let currentUserId: String
    private let coreLocationManager = CoreLocationManager()
    private let detailView = PatronOfferDetailView()
    
    private var scanStatus = false {
        didSet {
            if scanStatus {
                detailView.configureOfferClaimedState()
            }
        }
    }
    
    public weak var delegate: PatronOfferDetailDelegate?
    
    init(_ offer: Offer, _ venue: Venue, _ state: AppState) {
        let userId = Auth.auth().currentUser?.uid ?? "sdknaZ8oYlPI4w4XEQGOwUgIsXw2"
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
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        listener = Firestore.firestore().collection(DatabaseService.usersCollection).document(currentUserId).addSnapshotListener({ [weak self] (snapshot, error) in
            if let error = error {
                self?.showAlert(title: "Error", message: "Could not retrieve qrCode scanned status. Error: \(error.localizedDescription)")
            } else if let snapshot = snapshot, let status = snapshot.data()?["qrCodeScanned"] as? Bool {
                self?.scanStatus =  status
            }
        })
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        listener?.remove()
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
            if let offerName = UserDefaultsHandler.getOfferName(), offerName == currentOffer.nameOfOffer {
                detailView.configureClaimedCurrentOfferState(offerName, currentOffer.offerId, currentUserId)
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
        DatabaseService.shared.claimOffer(currentVenue.venueId, currentOffer.offerId, currentUserId) { [weak self] result in
            switch result {
            case .failure(let error):
                self?.showAlert(title: "Error", message: "Could not successfully claim offer: \(error.localizedDescription)") { [weak self] alertAction in
                    self?.navigationController?.popViewController(animated: true)
                }
            case .success:
                self?.showAlert(title: "Success", message: "You will be able to claim another meal on \(DateHandler.convertDateToString(DateHandler.calculateNextClaimDate(), true)).")
                self?.setClaimedState()
            }
        }
    }
    
    private func setTimeToNextClaim(){
        let date = DateHandler.calculateNextClaimDate()
        DatabaseService.shared.updateTimeOfNextClaim(currentUserId, date) { [weak self] (result) in
            switch result {
            case .failure(let error):
                self?.showAlert(title: "Error", message: "Could not update time of next offer. Error: \(error.localizedDescription).")
            case .success:
                self?.showAlert(title: "Success", message: "You can claim another meal at \(DateHandler.convertDateToString(date, true)).")
            }
        }
    }
    
    private func setClaimedState() {
        let qrCodeString = "\(currentOffer.nameOfOffer) \(DateHandler.convertDateToString(Date())) \(currentOffer.offerId) \(currentUserId)"
        detailView.claimOfferButton.alpha = 0.0
        detailView.forfeitOfferButton.alpha = 1.0
        detailView.willGenerateCodeLabel.isHidden = true
        detailView.qrCodeImageView.image = QRCodeHandler.generateQRCode(from: qrCodeString)
        DatabaseService.shared.updateStatus(currentUserId, "claimed") { [weak self] result in
            switch result {
            case .failure(let error):
                self?.showAlert(title: "Update Error", message: "Could not update claim status: \(error.localizedDescription)")
            case .success:
                break
            }
        }
        delegate?.stateChanged(self, AppState.offerClaimed)
        UserDefaultsHandler.saveOfferName(currentOffer.nameOfOffer)
        setTimeToNextClaim()
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
        DatabaseService.shared.forfeitOffer(currentVenue.venueId, currentOffer.offerId, currentUserId) {
            [weak self] result in
            switch result {
            case .failure(let error):
                self?.showAlert(title: "Error", message: "Could not forfeit error: \(error.localizedDescription)")
            case .success:
                self?.showAlert(title: "Success", message: "Meal successfully forfeited. You will be able to claim another meal on \(DateHandler.convertDateToString(DateHandler.calculateNextClaimDate(), true))")
            }
        }
        detailView.configureOfferClaimedState()
    }
    
    @objc
    private func getDirectionsButtonPressed(_ sender: UIButton) {
        let destinationPlacemark = MKPlacemark(coordinate: CLLocationCoordinate2D(latitude: currentVenue.lat, longitude: currentVenue.long))
        let destinationItem = MKMapItem(placemark: destinationPlacemark)
        destinationItem.name = currentVenue.name
        let launchOptions = [MKLaunchOptionsDirectionsModeKey: MKLaunchOptionsDirectionsModeDriving]
        destinationItem.openInMaps(launchOptions: launchOptions)
    }

}
