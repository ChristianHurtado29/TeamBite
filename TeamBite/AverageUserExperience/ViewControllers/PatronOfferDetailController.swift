//
//  PatronOfferDetailController.swift
//  TeamBite
//
//  Created by Cameron Rivera on 7/27/20.
//  Copyright © 2020 Christian Hurtado. All rights reserved.
//

import UIKit

// Disable claim offer from other offers.
// Move the mapView to this page. 

class PatronOfferDetailController: UIViewController {

    private let detailView = PatronOfferDetailView()
    private var mealState = MealStatus.unclaimed
    private let currentOffer: Offer
    
    init(_ offer: Offer) {
        currentOffer = offer
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
        detailView.claimOfferButton.alpha = 1.0
    }
    
    @objc
    private func claimOfferButtonPressed(_ sender: UIButton) {
        showOfferAlert("Claim Offer", "You are about to claim this meal. If you claim this meal, you will not be able to claim another. Are you sure you would like to claim this meal?") { (action) in
            self.detailView.claimOfferButton.alpha = 0.0
            self.detailView.forfeitOfferButton.alpha = 1.0
            // Write decrement meal code here.
        }
    }
    
    @objc
    private func forfeitOfferButtonPressed(_ sender: UIButton) {
        showOfferAlert("Forfeit Offer", "You are about to forfeit your claim to this meal. If you forfeit this meal, you will not be able to claim another until tomorrow. Are you sure that you would like to forfeit this meal?") { (action) in
            self.detailView.claimOfferButton.alpha = 1.0
            self.detailView.claimOfferButton.isUserInteractionEnabled = false
            self.detailView.forfeitOfferButton.alpha = 0.0
            // Return the meal back to being available.
        }
    }

}
