//
//  PatronOfferCell.swift
//  TeamBite
//
//  Created by Cameron Rivera on 7/24/20.
//  Copyright © 2020 Christian Hurtado. All rights reserved.
//

import UIKit
import Kingfisher

class PatronOfferCell: UITableViewCell {

    private lazy var offerImage: UIImageView = {
       let imageView = UIImageView()
        imageView.image = UIImage(systemName: "tortoise.fill")
        imageView.layer.cornerRadius = 30
        return imageView
    }()
    
    private lazy var offerTitleLabel: UILabel = {
       let label = UILabel()
        label.textColor = UIColor.black
        label.numberOfLines = 2
        label.textAlignment = .left
        return label
    }()
    
    private lazy var amountAvailableLabel: UILabel = {
       let label = UILabel()
        label.textColor = UIColor.black
        label.numberOfLines = 1
        label.textAlignment = .left
        return label
    }()
    
    private lazy var labelStack: UIStackView = {
       let stack = UIStackView()
        stack.axis = .vertical
        stack.distribution = .fillEqually
        return stack
    }()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        commonInit()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        commonInit()
    }
    
    private func commonInit(){
        setUpOfferImageConstraints()
        setUpLabelStackConstraints()
    }
    
    private func setUpOfferImageConstraints() {
        addSubview(offerImage)
        offerImage.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([offerImage.topAnchor.constraint(equalTo: contentView.safeAreaLayoutGuide.topAnchor, constant: 8), offerImage.trailingAnchor.constraint(equalTo: contentView.safeAreaLayoutGuide.trailingAnchor, constant: -8), offerImage.bottomAnchor.constraint(equalTo: contentView.safeAreaLayoutGuide.bottomAnchor, constant: -8), offerImage.widthAnchor.constraint(equalTo: contentView.widthAnchor, multiplier: 0.3)])
    }
    
    private func setUpLabelStackConstraints() {
        addSubview(labelStack)
        labelStack.addArrangedSubview(offerTitleLabel)
        labelStack.addArrangedSubview(amountAvailableLabel)
        labelStack.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([labelStack.topAnchor.constraint(equalTo: contentView.safeAreaLayoutGuide.topAnchor, constant: 8), labelStack.leadingAnchor.constraint(equalTo: safeAreaLayoutGuide.leadingAnchor, constant: 8), labelStack.trailingAnchor.constraint(equalTo: offerImage.leadingAnchor, constant: -8), labelStack.bottomAnchor.constraint(equalTo: contentView.safeAreaLayoutGuide.bottomAnchor, constant: -8)])
    }
    
    public func configureCell(_ offer: Offer) {
        offerTitleLabel.text = "Offer name: \(offer.nameOfOffer)"
        amountAvailableLabel.text = "Number remaining: \(offer.remainingMeals.description)"
        if let image = offer.offerImage, !image.isEmpty {
            offerImage.kf.setImage(with: URL(string: image))
        }else {
            offerImage.image = UIImage(systemName: "tortoise.fill")
        }
    }
}
