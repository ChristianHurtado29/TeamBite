//
//  MainViewCellCollectionViewCell.swift
//  TeamBite
//
//  Created by Margiett Gil on 4/21/20.
//  Copyright © 2020 Christian Hurtado. All rights reserved.
//

import UIKit

class MainViewCell: UICollectionViewCell {
    
    private var currentVenues: Venue!
    
    public lazy var view: UIView = {
        let layout = UIView()
        layout.backgroundColor = .white
        layout.layer.masksToBounds = false
        layout.clipsToBounds = false
        layout.layer.shadowColor = #colorLiteral(red: 0.6000000238, green: 0.6000000238, blue: 0.6000000238, alpha: 1)
        layout.layer.shadowOffset = CGSize.zero
        layout.layer.shadowRadius = 5
        layout.layer.cornerRadius = 8
        return layout
    }()
    
    public lazy var venueName: UILabel = {
        let layout = UILabel()
        layout.numberOfLines = 0
        layout.font = UIFont(name: "Hiragino Mincho ProN", size: 18)
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
        imageView.contentMode = .scaleAspectFill
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
        setupView()
        setRestImage()
        setupAddressLabel()
        setupHoursOfPickUp()
        
    }
    
    public func configureCell(savedVenues: Venue) {
           currentVenues = savedVenues
        venueName.text = ("\(savedVenues.name)")
        addressLabel.text = ("\(savedVenues.address)")
        phoneNumber.text = ("\(savedVenues.phoneNumber ?? "")")
           
        // keep in mind venue images match stock photo names
        restaurantImage.image = UIImage(named: savedVenues.name)
       }
    
    private func setupView(){
        addSubview(view)
        view.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            view.leadingAnchor.constraint(equalTo: safeAreaLayoutGuide.leadingAnchor, constant: 8),
            view.trailingAnchor.constraint(equalTo: safeAreaLayoutGuide.trailingAnchor, constant: -8),
            view.topAnchor.constraint(equalTo: safeAreaLayoutGuide.topAnchor,constant: 8)
        
        ])
    }
        private func setRestImage() {
            addSubview(restaurantImage)
            restaurantImage.translatesAutoresizingMaskIntoConstraints = false
            NSLayoutConstraint.activate([
                restaurantImage.centerXAnchor.constraint(equalTo: centerXAnchor),
                restaurantImage.centerYAnchor.constraint(equalTo: centerYAnchor),
                restaurantImage.heightAnchor.constraint(equalTo: heightAnchor, multiplier: 0.6),
                restaurantImage.widthAnchor.constraint(equalTo: widthAnchor, multiplier: 0.6)
            ])
        }
    
    private func setupAddressLabel() {
        addSubview(venueName)
        venueName.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            venueName.topAnchor.constraint(equalTo: restaurantImage.bottomAnchor, constant: 8),
            venueName.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 8),
            venueName.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -8)
        
        ])
    }
    
    private func setupHoursOfPickUp() {
        addSubview(phoneNumber)
        phoneNumber.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            phoneNumber.topAnchor.constraint(equalTo: venueName.bottomAnchor, constant: 8),
            phoneNumber.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 8),
            phoneNumber.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -8)
        
        ])
    }
    
    private func setupStatusLabel() {
        addSubview(addressLabel)
        addressLabel.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
        addressLabel.topAnchor.constraint(equalTo: phoneNumber.bottomAnchor, constant: 8),
        addressLabel.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 8),
        addressLabel.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -8)
        ])
    
    }
    
    
 
    
}
