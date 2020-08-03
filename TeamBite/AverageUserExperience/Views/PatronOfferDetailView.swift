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
    
    override init(frame: CGRect) {
        super.init(frame: UIScreen.main.bounds)
        commonInit()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        commonInit()
    }
    
    private func commonInit() {
        setUpQRCodeImageViewConstraints()
        setUpWillGenerateCodeLabelConstraints()
        setUpClaimOfferButtonConstraints()
        setUpForfeitOfferButtonConstraints()
    }
    
    private func setUpQRCodeImageViewConstraints() {
        addSubview(qrCodeImageView)
        qrCodeImageView.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([qrCodeImageView.topAnchor.constraint(equalTo: safeAreaLayoutGuide.topAnchor, constant: 20), qrCodeImageView.centerXAnchor.constraint(equalTo: centerXAnchor), qrCodeImageView.heightAnchor.constraint(equalTo: heightAnchor, multiplier: 0.4), qrCodeImageView.widthAnchor.constraint(equalTo: qrCodeImageView.heightAnchor)])
    }
    
    private func setUpWillGenerateCodeLabelConstraints() {
        qrCodeImageView.addSubview(willGenerateCodeLabel)
        willGenerateCodeLabel.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([willGenerateCodeLabel.centerXAnchor.constraint(equalTo: qrCodeImageView.centerXAnchor), willGenerateCodeLabel.leadingAnchor.constraint(equalTo: qrCodeImageView.leadingAnchor, constant: 8), willGenerateCodeLabel.trailingAnchor.constraint(equalTo: qrCodeImageView.trailingAnchor, constant: -8), willGenerateCodeLabel.centerYAnchor.constraint(equalTo: qrCodeImageView.centerYAnchor)])
    }
    
    private func setUpClaimOfferButtonConstraints() {
        addSubview(claimOfferButton)
        claimOfferButton.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([claimOfferButton.topAnchor.constraint(equalTo: qrCodeImageView.bottomAnchor, constant: 20), claimOfferButton.leadingAnchor.constraint(equalTo: safeAreaLayoutGuide.leadingAnchor, constant: 8), claimOfferButton.trailingAnchor.constraint(equalTo: safeAreaLayoutGuide.trailingAnchor, constant: -8), claimOfferButton.heightAnchor.constraint(equalToConstant: 50)])
    }
    
    private func setUpForfeitOfferButtonConstraints() {
        addSubview(forfeitOfferButton)
        forfeitOfferButton.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([forfeitOfferButton.topAnchor.constraint(equalTo: qrCodeImageView.bottomAnchor, constant: 20), forfeitOfferButton.leadingAnchor.constraint(equalTo: safeAreaLayoutGuide.leadingAnchor, constant: 8), forfeitOfferButton.trailingAnchor.constraint(equalTo: safeAreaLayoutGuide.trailingAnchor, constant: -8), forfeitOfferButton.heightAnchor.constraint(equalToConstant: 50)])
    }

}
