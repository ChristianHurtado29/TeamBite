//
//  FlagVendorViewController.swift
//  TeamBite
//
//  Created by Cameron Rivera on 10/4/20.
//  Copyright © 2020 Christian Hurtado. All rights reserved.
//

import UIKit

class FlagVendorViewController: UIViewController {

    private let flagView = FlagVendorView()
    private var currentVenue: Venue
    
    override func loadView() {
        view = flagView
    }
    
    init(_ venue: Venue) {
        self.currentVenue = venue
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("required init(_:) was not implemented.")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configureUI()
    }
    
    private func configureUI() {
        flagView.submitButton.addTarget(self, action: #selector(submitButtonPressed(_:)), for: .touchUpInside)
        flagView.venueNameTextField.text = currentVenue.name
    }
    
    @objc
    private func submitButtonPressed(_ sender: UIButton) {
        print("Submitted")
    }

}
