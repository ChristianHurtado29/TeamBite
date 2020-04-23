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

    public lazy var restaurantPhoto: UIImageView = {
        let imageView = UIImageView()
        imageView.image = UIImage(systemName: "photo.fill")
        imageView.tintColor = #colorLiteral(red: 0.501960814, green: 0.501960814, blue: 0.501960814, alpha: 1)
        imageView.contentMode = .scaleAspectFill
        return imageView
    }()
    
   public lazy var restaurantInfo: UILabel = {
         let layout = UILabel()
         layout.numberOfLines = 2
         layout.font = UIFont(name: "Hiragino Mincho ProN", size: 15)
         layout.textColor = .black
         layout.textAlignment = .left
         return layout
         
     }()
     
     public lazy var hoursOFOperation: UILabel = {
         let layout = UILabel()
         layout.numberOfLines = 2
         layout.font = UIFont(name: "Hiragino Mincho ProN", size: 15)
         layout.textColor = .black
         layout.textAlignment = .left
         return layout
     }()
     
     public lazy var numberOfMeals: UILabel = {
         let layout = UILabel()
         layout.numberOfLines = 2
         layout.font = UIFont(name: "Hiragino Mincho ProN", size: 15)
         layout.textColor = .black
         layout.textAlignment = .left
         return layout
     }()
    
    public lazy var claimButton: UIButton = {
        let button = UIButton()
        button.setTitle("Claim Meal", for: .normal)
        button.backgroundColor = #colorLiteral(red: 0.8078431487, green: 0.02745098062, blue: 0.3333333433, alpha: 1)
        button.layer.cornerRadius = 5.0
        button.setTitleColor(.white, for: .normal)
        button.titleLabel?.font = UIFont.systemFont(ofSize: 15, weight: UIFont.Weight.semibold)
        return button
    }()
    
    public lazy var locationMap: MKMapView = {
    let map = MKMapView()
        return map
    }()
    
    public lazy var getDirectionButton: UIButton = {
        let button = UIButton()
        button.setTitle("Get Direction", for: .normal)
        button.backgroundColor = #colorLiteral(red: 0.8078431487, green: 0.02745098062, blue: 0.3333333433, alpha: 1)
        button.layer.cornerRadius = 5.0
        button.titleLabel?.font = UIFont.systemFont(ofSize: 15, weight: UIFont.Weight.semibold)
        button.setTitleColor(.white, for: .normal)
        return button
    }()
    
    override init(frame: CGRect) {
        super.init(frame: UIScreen.main.bounds)
        commonInit()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
    }
    
    private func commonInit() {
        setupRestaurant()
        setupRestaurantInfo()
        setupHours()
        setupNumberOfMeals()
        setupButton()
        setupMap()
        setupGetDirection()
    }
    
    private func setupRestaurant() { // This is a image
        addSubview(restaurantPhoto)
        restaurantPhoto.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            restaurantPhoto.centerXAnchor.constraint(equalTo: centerXAnchor),
            restaurantPhoto.centerYAnchor.constraint(equalTo: centerYAnchor),
            restaurantPhoto.heightAnchor.constraint(equalTo: heightAnchor, multiplier: 0.12),
            restaurantPhoto.widthAnchor.constraint(equalTo: widthAnchor, multiplier: 0.12)
        ])
    }
     
    private func setupRestaurantInfo() { // this is a label
        addSubview(restaurantInfo)
        restaurantInfo.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            restaurantInfo.topAnchor.constraint(equalTo: restaurantPhoto.bottomAnchor, constant: 8),
            restaurantInfo.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 8),
            restaurantInfo.trailingAnchor.constraint(equalTo: trailingAnchor, constant:  -8),
        ])
    }
    
    private func setupHours() { // This is a Label
        addSubview(hoursOFOperation)
        hoursOFOperation.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            hoursOFOperation.topAnchor.constraint(equalTo: restaurantInfo.bottomAnchor, constant: 8),
            hoursOFOperation.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 8),
            hoursOFOperation.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -8)
        ])
    }
    
    private func setupNumberOfMeals() { // This is a Label
        addSubview(numberOfMeals)
        numberOfMeals.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            numberOfMeals.topAnchor.constraint(equalTo: hoursOFOperation.bottomAnchor, constant: 8),
            numberOfMeals.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 8),
            numberOfMeals.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -8)
    
        ])
        
    }
    
    private func setupButton() {
        addSubview(claimButton)
        claimButton.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            claimButton.topAnchor.constraint(equalTo: numberOfMeals.bottomAnchor, constant: 8),
            claimButton.centerXAnchor.constraint(equalTo: centerXAnchor),
            claimButton.centerYAnchor.constraint(equalTo: centerYAnchor)
        
        ])
    }
    
    private func setupMap() {
        addSubview(locationMap)
        locationMap.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            locationMap.topAnchor.constraint(equalTo: claimButton.bottomAnchor, constant: 10),
            locationMap.leadingAnchor.constraint(equalTo: safeAreaLayoutGuide.leadingAnchor, constant: 8),
            locationMap.trailingAnchor.constraint(equalTo: safeAreaLayoutGuide.trailingAnchor, constant: -8)
            
        ])
    }
    
    private func setupGetDirection() {
        addSubview(getDirectionButton)
        getDirectionButton.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            getDirectionButton.topAnchor.constraint(equalTo: locationMap.bottomAnchor, constant: 8),
            getDirectionButton.centerXAnchor.constraint(equalTo: centerXAnchor),
            getDirectionButton.centerYAnchor.constraint(equalTo: centerYAnchor)
        
        ])
    }

}
