//
//  PatronOfferDetailController.swift
//  TeamBite
//
//  Created by Cameron Rivera on 7/27/20.
//  Copyright © 2020 Christian Hurtado. All rights reserved.
//

import UIKit

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
    
    public weak var delegate: PatronOfferDetailDelegate?
    
    init(_ offer: Offer, _ venue: Venue, _ state: AppState) {
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
    }
    
    private func setUpUI() {
        navigationItem.title = currentOffer.nameOfOffer
        navigationController?.navigationBar.tintColor = #colorLiteral(red: 0.8549019694, green: 0.250980407, blue: 0.4784313738, alpha: 1)
        detailView.backgroundColor = UIColor.systemBackground
        detailView.claimOfferButton.addTarget(self, action: #selector(claimOfferButtonPressed(_:)), for: .touchUpInside)
        detailView.forfeitOfferButton.addTarget(self, action: #selector(forfeitOfferButtonPressed(_:)), for: .touchUpInside)
        if currentState == AppState.offerClaimed{
            if UserDefaultsHandler.getOfferName() ?? "" == currentOffer.nameOfOffer {
                detailView.forfeitOfferButton.alpha = 1.0
                detailView.willGenerateCodeLabel.isHidden = true
                detailView.qrCodeImageView.image = QRCodeHandler.generateQRCode(from: currentOffer.nameOfOffer)
            } else {
                detailView.claimOfferButton.alpha = 1.0
                detailView.claimOfferButton.isUserInteractionEnabled = false
                detailView.qrCodeImageView.image = nil
                detailView.willGenerateCodeLabel.isHidden = false
                detailView.willGenerateCodeLabel.text = "You will have to wait until tomorrow to claim a new offer."
            }
        } else {
            detailView.claimOfferButton.alpha = 1.0
            detailView.forfeitOfferButton.alpha = 0.0
        }
    }
    
    @objc
    private func claimOfferButtonPressed(_ sender: UIButton) {
        showOfferAlert("Claim Offer", "You are about to claim this meal. If you claim this meal, you will not be able to claim another. Are you sure you would like to claim this meal?") { [weak self] (action) in
            self?.claimedButtonUpdates()
        }
    }
    
    private func claimedButtonUpdates() {
        detailView.claimOfferButton.alpha = 0.0
        detailView.forfeitOfferButton.alpha = 1.0
        detailView.willGenerateCodeLabel.isHidden = true
        detailView.qrCodeImageView.image = QRCodeHandler.generateQRCode(from: currentOffer.nameOfOffer)
        UserDefaultsHandler.setStateToClaimed()
        UserDefaultsHandler.saveOfferName(currentOffer.nameOfOffer)
        DatabaseService.shared.claimOffer(currentVenue.venueId, currentOffer.offerId)
        delegate?.stateChanged(self, AppState.offerClaimed)
    }
    
    @objc
    private func forfeitOfferButtonPressed(_ sender: UIButton) {
        showOfferAlert("Forfeit Offer", "You are about to forfeit your claim to this meal. If you forfeit this meal, you will not be able to claim another until tomorrow. Are you sure that you would like to forfeit this meal?") { [weak self] (action) in
            self?.forfeitButtonUpdates()
        }
    }
    
    private func forfeitButtonUpdates() {
        detailView.claimOfferButton.alpha = 1.0
        detailView.claimOfferButton.isUserInteractionEnabled = false
        detailView.forfeitOfferButton.alpha = 0.0
        UserDefaultsHandler.resetOfferName()
        // Return the meal back to being available.
    }

}
