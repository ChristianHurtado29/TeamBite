//
//  PatronOfferDetailView.swift
//  TeamBite
//
//  Created by Cameron Rivera on 7/27/20.
//  Copyright © 2020 Christian Hurtado. All rights reserved.
//

enum MealStatus {
    case claimed
    case unclaimed
}

import UIKit
import MapKit

class PatronOfferDetailView: UIView {
    
    public var topMapConstraint = NSLayoutConstraint()
    private var topMapConstant: CGFloat = 0.0
    private var shiftAmount: CGFloat = 90.0
    
    public lazy var qrCodeImageView: UIImageView = {
       let iv = UIImageView()
        iv.layer.borderColor = UIColor.black.cgColor
        iv.layer.borderWidth = 1.0
        return iv
    }()
    
    public lazy var willGenerateCodeLabel: UILabel = {
       let label = UILabel()
        label.textColor = UIColor.black
        label.textAlignment = .center
        label.numberOfLines = 0
        label.text = "QR Code will be generated after offer is claimed."
        return label
    }()
    
    public lazy var claimOfferButton: UIButton = {
       let button = UIButton()
        button.setTitle("Claim Offer", for: .normal)
        button.setTitleColor(UIColor.white, for: .normal)
        button.backgroundColor = #colorLiteral(red: 0.8078431487, green: 0.02745098062, blue: 0.3333333433, alpha: 1)
        button.titleLabel?.font = UIFont.systemFont(ofSize: 15, weight: UIFont.Weight.semibold)
        button.alpha = 0.0
        return button
    }()
    
    public lazy var forfeitOfferButton: UIButton = {
        let button = UIButton()
        button.setTitle("Forfeit Offer", for: .normal)
        button.setTitleColor(UIColor.white, for: .normal)
        button.backgroundColor = #colorLiteral(red: 0.8078431487, green: 0.02745098062, blue: 0.3333333433, alpha: 1)
        button.titleLabel?.font = UIFont.systemFont(ofSize: 15, weight: UIFont.Weight.semibold)
        button.alpha = 0.0
        return button
    }()
    
    public lazy var pickUpDirectionsLabel: UILabel = {
       let label = UILabel()
        label.textAlignment = .center
        label.text = "Pick Up Directions"
        label.font = UIFont.preferredFont(forTextStyle: .headline)
        label.alpha = 1.0
        return label
    }()
    
    public lazy var pickUpDetailsLabel: UILabel = {
       let label = UILabel()
        label.textAlignment = .center
        label.text = ""
        label.alpha = 1.0
        return label
    }()
    
    public lazy var scrollView: UIScrollView = {
        let scroll = UIScrollView()
        scroll.isScrollEnabled = true
        scroll.backgroundColor = UIColor.systemBackground
        return scroll
    }()
    
    public lazy var mapView: MKMapView = {
       let mapView = MKMapView()
        mapView.showsUserLocation = true
        mapView.isZoomEnabled = true
        mapView.isUserInteractionEnabled = false
        return mapView
    }()
    
    public lazy var getDirectionsButton: UIButton = {
       let button = UIButton()
        button.setTitle("Get Directions", for: .normal)
        button.setTitleColor(UIColor.white, for: .normal)
        button.titleLabel?.font = UIFont.systemFont(ofSize: 15, weight: UIFont.Weight.semibold)
        button.backgroundColor = #colorLiteral(red: 0.8078431487, green: 0.02745098062, blue: 0.3333333433, alpha: 1)
        return button
    }()
    
    override init(frame: CGRect) {
        super.init(frame: UIScreen.main.bounds)
        commonInit()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        commonInit()
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        scrollView.contentSize = CGSize(width: UIScreen.main.bounds.width, height: UIScreen.main.bounds.height + UIScreen.main.bounds.height * 0.3)
    }
    
    private func commonInit() {
        setUpScrollViewConstraints()
        setUpQRCodeImageViewConstraints()
        setUpWillGenerateCodeLabelConstraints()
        setUpClaimOfferButtonConstraints()
        setUpForfeitOfferButtonConstraints()
        setUpPickUpDirectionsLabelConstraints()
        setUpPickUpDetailsLabelConstraints()
        setUpMapViewConstraints()
        setUpGetDirectionsButtonConstraints()
        setUpConstraintVariables()
    }
    
    private func setUpScrollViewConstraints() {
        addSubview(scrollView)
        scrollView.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([scrollView.topAnchor.constraint(equalTo: safeAreaLayoutGuide.topAnchor),scrollView.leadingAnchor.constraint(equalTo: safeAreaLayoutGuide.leadingAnchor), scrollView.trailingAnchor.constraint(equalTo: safeAreaLayoutGuide.trailingAnchor), scrollView.bottomAnchor.constraint(equalTo: safeAreaLayoutGuide.bottomAnchor)])
    }
    
    private func setUpQRCodeImageViewConstraints() {
        scrollView.addSubview(qrCodeImageView)
        qrCodeImageView.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([qrCodeImageView.topAnchor.constraint(equalTo: scrollView.topAnchor, constant: 20), qrCodeImageView.centerXAnchor.constraint(equalTo: scrollView.centerXAnchor), qrCodeImageView.heightAnchor.constraint(equalTo: scrollView.heightAnchor, multiplier: 0.4), qrCodeImageView.widthAnchor.constraint(equalTo: qrCodeImageView.heightAnchor)])
    }
    
    private func setUpWillGenerateCodeLabelConstraints() {
        qrCodeImageView.addSubview(willGenerateCodeLabel)
        willGenerateCodeLabel.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([willGenerateCodeLabel.centerXAnchor.constraint(equalTo: qrCodeImageView.centerXAnchor), willGenerateCodeLabel.leadingAnchor.constraint(equalTo: qrCodeImageView.leadingAnchor, constant: 8), willGenerateCodeLabel.trailingAnchor.constraint(equalTo: qrCodeImageView.trailingAnchor, constant: -8), willGenerateCodeLabel.centerYAnchor.constraint(equalTo: qrCodeImageView.centerYAnchor)])
    }
    
    private func setUpClaimOfferButtonConstraints() {
        scrollView.addSubview(claimOfferButton)
        claimOfferButton.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([claimOfferButton.topAnchor.constraint(equalTo: qrCodeImageView.bottomAnchor, constant: 20), claimOfferButton.leadingAnchor.constraint(equalTo: safeAreaLayoutGuide.leadingAnchor, constant: 8), claimOfferButton.trailingAnchor.constraint(equalTo: safeAreaLayoutGuide.trailingAnchor, constant: -8), claimOfferButton.heightAnchor.constraint(equalToConstant: 50)])
    }
    
    private func setUpForfeitOfferButtonConstraints() {
        scrollView.addSubview(forfeitOfferButton)
        forfeitOfferButton.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([forfeitOfferButton.topAnchor.constraint(equalTo: qrCodeImageView.bottomAnchor, constant: 20), forfeitOfferButton.leadingAnchor.constraint(equalTo: safeAreaLayoutGuide.leadingAnchor, constant: 8), forfeitOfferButton.trailingAnchor.constraint(equalTo: safeAreaLayoutGuide.trailingAnchor, constant: -8), forfeitOfferButton.heightAnchor.constraint(equalToConstant: 50)])
    }
    
    private func setUpPickUpDirectionsLabelConstraints() {
        scrollView.addSubview(pickUpDirectionsLabel)
        pickUpDirectionsLabel.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([pickUpDirectionsLabel.topAnchor.constraint(equalTo: claimOfferButton.bottomAnchor, constant: 20), pickUpDirectionsLabel.leadingAnchor.constraint(equalTo: safeAreaLayoutGuide.leadingAnchor, constant: 8), pickUpDirectionsLabel.trailingAnchor.constraint(equalTo: safeAreaLayoutGuide.trailingAnchor, constant: -8)])
    }
    
    private func setUpPickUpDetailsLabelConstraints() {
        scrollView.addSubview(pickUpDetailsLabel)
        pickUpDetailsLabel.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([pickUpDetailsLabel.topAnchor.constraint(equalTo: pickUpDirectionsLabel.bottomAnchor, constant: 20), pickUpDetailsLabel.leadingAnchor.constraint(equalTo: safeAreaLayoutGuide.leadingAnchor, constant: 8), pickUpDetailsLabel.trailingAnchor.constraint(equalTo: safeAreaLayoutGuide.trailingAnchor, constant: -8)])
    }
    
    private func setUpMapViewConstraints() {
        scrollView.addSubview(mapView)
        mapView.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([mapView.leadingAnchor.constraint(equalTo: safeAreaLayoutGuide.leadingAnchor), mapView.trailingAnchor.constraint(equalTo: safeAreaLayoutGuide.trailingAnchor), mapView.heightAnchor.constraint(equalTo: heightAnchor, multiplier: 0.5)])
        
        topMapConstraint = mapView.topAnchor.constraint(equalTo: claimOfferButton.bottomAnchor, constant: 20)
        topMapConstraint.isActive = true
    }
    
    private func setUpGetDirectionsButtonConstraints() {
        scrollView.addSubview(getDirectionsButton)
        getDirectionsButton.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([getDirectionsButton.topAnchor.constraint(equalTo: mapView.bottomAnchor, constant: 20), getDirectionsButton.leadingAnchor.constraint(equalTo: safeAreaLayoutGuide.leadingAnchor, constant: 8), getDirectionsButton.trailingAnchor.constraint(equalTo: safeAreaLayoutGuide.trailingAnchor, constant: -8), getDirectionsButton.heightAnchor.constraint(equalToConstant: 50)])
    }
    
    private func setUpConstraintVariables() {
        topMapConstant = topMapConstraint.constant
    }
    
    public func configureClaimedCurrentOfferState(_ offerName: String, _ offerId: String, _ userId: String) {
        let qrCodeString = "\(offerName) \(DateHandler.convertDateToString(Date())) \(offerId) \(userId)"
        forfeitOfferButton.alpha = 1.0
        willGenerateCodeLabel.isHidden = true
        qrCodeImageView.image = QRCodeHandler.generateQRCode(from: qrCodeString)
        showPickUpDirections()
    }
    
    public func configureOfferClaimedState() {
        claimOfferButton.alpha = 1.0
        claimOfferButton.isUserInteractionEnabled = false
        qrCodeImageView.image = nil
        willGenerateCodeLabel.isHidden = false
        willGenerateCodeLabel.text = "You will have to wait until tomorrow to claim a new offer."
    }
    
    public func showPickUpDirections() {
        
        self.topMapConstraint.constant += self.shiftAmount
        
        UIView.animate(withDuration: 1.0, delay: 0.0, options: [.curveEaseInOut], animations: {
            self.pickUpDirectionsLabel.alpha = 1.0
            self.pickUpDirectionsLabel.alpha = 1.0
            self.layoutIfNeeded()
        })
    }
    
    public func configureUnclaimedOfferState() {
        claimOfferButton.alpha = 1.0
        forfeitOfferButton.alpha = 0.0
    }
    
    public func hidePickUpInstructions() {
        
        self.topMapConstraint.constant = topMapConstant
        
        UIView.animate(withDuration: 1.0, delay: 0.0, options: [.curveEaseInOut], animations: {
            self.pickUpDirectionsLabel.alpha = 0.0
            self.pickUpDirectionsLabel.alpha = 0.0
            self.layoutIfNeeded()
        })
    }
}
