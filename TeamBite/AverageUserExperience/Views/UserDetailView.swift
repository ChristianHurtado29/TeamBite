//
//  UserDetailView.swift
//  TeamBite
//
//  Created by Margiett Gil on 4/21/20.
//  Copyright © 2020 Christian Hurtado. All rights reserved.
//

import UIKit
import MapKit

class UserDetailView: UIView {

    public lazy var addressLabel: UILabel = {
        let layout = UILabel()
        layout.text = "FILLER ADDRESS"
        layout.numberOfLines = 2
        layout.font = UIFont(name: "Hiragino Mincho ProN", size: 15)
        layout.textColor = .black
        layout.textAlignment = .left
        return layout
    }()
    
    public lazy var phoneNumberLabel: UILabel = {
        let layout = UILabel()
        layout.text = "FILLER Phone"
        layout.numberOfLines = 2
        layout.font = UIFont(name: "Hiragino Mincho ProN", size: 15)
        layout.textColor = .black
        layout.textAlignment = .left
        return layout
        
    }()
    
    public lazy var numberOfMeals: UILabel = {
        let layout = UILabel()
        layout.numberOfLines = 0
        layout.font = UIFont(name: "Hiragino Mincho ProN", size: 15)
        layout.textColor = .black
        layout.textAlignment = .left
        return layout
    }()
    
    public lazy var activeOffersLabel: UILabel = {
        let label = UILabel()
        label.textColor = UIColor.black
        label.numberOfLines = 1
        label.textAlignment = .center
        label.text = "Active Offers"
        return label
    }()
    
    public lazy var offersTableView: UITableView = {
        let tableView = UITableView()
        tableView.register(PatronOfferCell.self, forCellReuseIdentifier: "offerCell")
        tableView.layer.borderWidth = 1.0
        tableView.layer.borderColor = UIColor.black.cgColor
        return tableView
    }()
    
    public lazy var flagRestaurantButton: UIBarButtonItem = {
       let barButtonItem = UIBarButtonItem()
        barButtonItem.image = UIImage(systemName: "flag.fill")
        return barButtonItem
    }()
    
    override init(frame: CGRect) {
        super.init(frame: UIScreen.main.bounds)
        commonInit()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
    }
    
    private func commonInit() {
        setupVenueAddress()
        setupPhoneNumber()
        setUpActiveOffersLabelConstraints()
        setUpOffersTableViewConstraints()
    }
    
    private func setupVenueAddress() {
        addSubview(addressLabel)
        addressLabel.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            addressLabel.topAnchor.constraint(equalTo: safeAreaLayoutGuide.topAnchor, constant: 20),
            addressLabel.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 8),
            addressLabel.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -8)
            
        ])
    }
    
    private func setupPhoneNumber() {
        addSubview(phoneNumberLabel)
        phoneNumberLabel.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            phoneNumberLabel.topAnchor.constraint(equalTo: addressLabel.bottomAnchor, constant:  10),
            phoneNumberLabel.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 8),
            phoneNumberLabel.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -8)
            
        ])
    }
    
    private func setUpActiveOffersLabelConstraints() {
        addSubview(activeOffersLabel)
        activeOffersLabel.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([activeOffersLabel.topAnchor.constraint(equalTo: phoneNumberLabel.bottomAnchor, constant: 20), activeOffersLabel.leadingAnchor.constraint(equalTo: safeAreaLayoutGuide.leadingAnchor, constant: 8), activeOffersLabel.trailingAnchor.constraint(equalTo: safeAreaLayoutGuide.trailingAnchor, constant: -8)])
    }
    
    private func setUpOffersTableViewConstraints() {
        addSubview(offersTableView)
        offersTableView.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([offersTableView.topAnchor.constraint(equalTo: activeOffersLabel.bottomAnchor, constant: 20), offersTableView.leadingAnchor.constraint(equalTo: safeAreaLayoutGuide.leadingAnchor, constant: 8), offersTableView.trailingAnchor.constraint(equalTo: safeAreaLayoutGuide.trailingAnchor, constant: -8), offersTableView.bottomAnchor.constraint(equalTo: safeAreaLayoutGuide.bottomAnchor, constant: -8)])
    }
    
}
