//
//  PatronOfferDetailView.swift
//  TeamBite
//
//  Created by Cameron Rivera on 7/27/20.
//  Copyright © 2020 Christian Hurtado. All rights reserved.
//

import UIKit

class PatronOfferDetailView: UIView {
    
    public lazy var qrCodeImageView: UIImageView = {
       let iv = UIImageView()
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
        button.setTitleColor(UIColor.blue, for: .normal)
        return button
    }()

}
