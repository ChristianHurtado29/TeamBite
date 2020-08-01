//
//  PatronOfferDetailController.swift
//  TeamBite
//
//  Created by Cameron Rivera on 7/27/20.
//  Copyright © 2020 Christian Hurtado. All rights reserved.
//

import UIKit

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
        
    }

}
