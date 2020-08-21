//
//  MainViewCellCollectionViewCell.swift
//  TeamBite
//
//  Created by Margiett Gil on 4/21/20.
//  Copyright © 2020 Christian Hurtado. All rights reserved.
//

import UIKit
import Kingfisher
import FirebaseAuth

class MainViewCell: UICollectionViewCell {
    
    private var currentVenue: Venue!
    
     public lazy var view: UIView = {
           let layout = UIView()
           layout.backgroundColor = .white
           layout.layer.masksToBounds = false
           layout.clipsToBounds = false
           layout.layer.shadowColor = #colorLiteral(red: 0.6000000238, green: 0.6000000238, blue: 0.6000000238, alpha: 1)
           layout.layer.shadowOpacity = 0.5
           layout.layer.shadowOffset = CGSize.zero
           layout.layer.shadowRadius = 5
           layout.layer.cornerRadius = 8
           return layout
       }()
    
    public lazy var venueName: UILabel = {
        let layout = UILabel()
        layout.text = "Name Appears Here"
        layout.numberOfLines = 0
        layout.font = UIFont(name: "Hiragino Mincho ProN", size: 17)
        layout.textColor = .black
        layout.textAlignment = .left
        return layout
        
    }()
    
    public lazy var addressLabel: UILabel = {
        let layout = UILabel()
        layout.numberOfLines = 0
        layout.font = UIFont(name: "Hiragino Mincho ProN", size: 15)
        layout.textColor = #colorLiteral(red: 0.6000000238, green: 0.6000000238, blue: 0.6000000238, alpha: 1)
        layout.textAlignment = .left
        return layout
    }()
    
    public lazy var phoneNumber: UILabel = {
        let layout = UILabel()
        layout.font = UIFont(name: "Hiragino Mincho ProN", size: 15)
        layout.textColor = #colorLiteral(red: 0.6000000238, green: 0.6000000238, blue: 0.6000000238, alpha: 1)
        layout.textAlignment = .left
        return layout
    }()
    
    public lazy var restaurantImage: UIImageView = {
        let imageView = UIImageView()
        imageView.image = UIImage(systemName: "photo.fill")
        imageView.tintColor = #colorLiteral(red: 0.501960814, green: 0.501960814, blue: 0.501960814, alpha: 1)
        //imageView.contentMode = .scaleAspectFill This line was causing the image to expand past its bounds.
        return imageView
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        commonInit()
    }
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        commonInit()
    }
    
    private func commonInit() {
        configureCellEffects()
        //configView()
        configImage()
        configVenueName()
        configPhoneNumber()
//        setupStatusLabel()
        
    }
    
    public func configureCell(savedVenue: Venue) {
        currentVenue = savedVenue
        venueName.text = ("\(savedVenue.name)")
        addressLabel.text = ("\(savedVenue.address)")
        phoneNumber.text = ("\(savedVenue.phoneNumber ?? "")")
        
        // keep in mind venue images match stock photo names (The case is off)
        // restaurantImage.image = UIImage(named: savedVenue.name)
        restaurantImage.image = UIImage(systemName: "hare")
    }
    
    private func configView(){
        addSubview(view)
        view.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            view.leadingAnchor.constraint(equalTo: safeAreaLayoutGuide.leadingAnchor),
            view.trailingAnchor.constraint(equalTo: safeAreaLayoutGuide.trailingAnchor),
            view.topAnchor.constraint(equalTo: safeAreaLayoutGuide.topAnchor),
            view.bottomAnchor.constraint(equalTo: safeAreaLayoutGuide.bottomAnchor)
            
        ])
    }
    
    private func configImage() {
        addSubview(restaurantImage)
        restaurantImage.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            restaurantImage.topAnchor.constraint(equalTo: safeAreaLayoutGuide.topAnchor, constant: 10),
            restaurantImage.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 8),
            restaurantImage.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -8),
            restaurantImage.heightAnchor.constraint(equalTo: heightAnchor, multiplier: 0.50)
        ])
    }
    
    private func configVenueName() {
        addSubview(venueName)
        venueName.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            venueName.topAnchor.constraint(equalTo: restaurantImage.bottomAnchor, constant: 15),
            venueName.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 8),
            venueName.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -8)
        ])
    }
    
    private func configPhoneNumber() {
        addSubview(phoneNumber)
        phoneNumber.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            phoneNumber.topAnchor.constraint(equalTo: venueName.bottomAnchor, constant: 10),
            phoneNumber.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 8),
            phoneNumber.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -8)
        ])
    }
    
    private func configAddress() {
        addSubview(addressLabel)
        addressLabel.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            addressLabel.topAnchor.constraint(equalTo: phoneNumber.bottomAnchor, constant: 8),
            addressLabel.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 8),
            addressLabel.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -8)
        ])
    }
    
    public func configureCellEffects() {
        self.layer.masksToBounds = false
        self.layer.shadowColor = #colorLiteral(red: 0.6000000238, green: 0.6000000238, blue: 0.6000000238, alpha: 1)
        self.layer.shadowOpacity = 0.5
        self.layer.shadowOffset = CGSize.zero
        self.layer.shadowRadius = 5
        self.layer.cornerRadius = 8
        self.backgroundColor = UIColor.white
        self.clipsToBounds = false
    }
    
}
