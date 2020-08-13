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
        scrollView.contentSize = CGSize(width: UIScreen.main.bounds.width, height: UIScreen.main.bounds.height + UIScreen.main.bounds.height * 0.2)
    }
    
    private func commonInit() {
        setUpScrollViewConstraints()
        setUpQRCodeImageViewConstraints()
        setUpWillGenerateCodeLabelConstraints()
        setUpClaimOfferButtonConstraints()
        setUpForfeitOfferButtonConstraints()
        setUpMapViewConstraints()
        setUpGetDirectionsButtonConstraints()
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
    
    private func setUpMapViewConstraints() {
        scrollView.addSubview(mapView)
        mapView.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([mapView.topAnchor.constraint(equalTo: claimOfferButton.bottomAnchor, constant: 20), mapView.leadingAnchor.constraint(equalTo: safeAreaLayoutGuide.leadingAnchor), mapView.trailingAnchor.constraint(equalTo: safeAreaLayoutGuide.trailingAnchor), mapView.heightAnchor.constraint(equalTo: heightAnchor, multiplier: 0.5)])
    }
    
    private func setUpGetDirectionsButtonConstraints() {
        scrollView.addSubview(getDirectionsButton)
        getDirectionsButton.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([getDirectionsButton.topAnchor.constraint(equalTo: mapView.bottomAnchor, constant: 20), getDirectionsButton.leadingAnchor.constraint(equalTo: safeAreaLayoutGuide.leadingAnchor, constant: 8), getDirectionsButton.trailingAnchor.constraint(equalTo: safeAreaLayoutGuide.trailingAnchor, constant: -8), getDirectionsButton.heightAnchor.constraint(equalToConstant: 50)])
    }
    
    public func configureClaimedCurrentOfferState(_ offerName: String) {
        forfeitOfferButton.alpha = 1.0
        willGenerateCodeLabel.isHidden = true
        qrCodeImageView.image = QRCodeHandler.generateQRCode(from: offerName)
    }
    
    public func configureOfferClaimedState() {
        claimOfferButton.alpha = 1.0
        claimOfferButton.isUserInteractionEnabled = false
        qrCodeImageView.image = nil
        willGenerateCodeLabel.isHidden = false
        willGenerateCodeLabel.text = "You will have to wait until tomorrow to claim a new offer."
    }
    
    public func configureUnclaimedOfferState() {
        claimOfferButton.alpha = 1.0
        forfeitOfferButton.alpha = 0.0
    }

}
