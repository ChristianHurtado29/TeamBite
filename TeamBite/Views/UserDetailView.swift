//
//  UserDetailView.swift
//  TeamBite
//
//  Created by Margiett Gil on 4/21/20.
//  Copyright © 2020 Christian Hurtado. All rights reserved.
//

import UIKit
import MapKit

import UIKit
import MapKit

class UserDetailView: UIView {
    
    lazy var contentViewSize = CGSize(width: centerView.frame.width , height: centerView.frame.height + 400)
    
    public lazy var scrollView: UIScrollView = {
        let view = UIScrollView(frame: .zero)
        view.frame = self.bounds
        
        view.contentSize = CGSize(width: (self.frame.width * 0.100), height: (self.frame.height * 0.700))
        view.backgroundColor = .white
        return view
    }()
    
    public var centerView: UIView = {
        let view = UIView()
        view.backgroundColor = .white
        return view
        
    }()
    
    
    
    public lazy var restaurantPhoto: UIImageView = {
        let imageView = UIImageView()
        imageView.image = UIImage(systemName: "photo.fill")
        imageView.tintColor = #colorLiteral(red: 0.501960814, green: 0.501960814, blue: 0.501960814, alpha: 1)
        imageView.contentMode = .scaleAspectFill
        return imageView
    }()
    
    public lazy var thisNeedsTobeRefactor: UILabel = {
        let layout = UILabel()
        layout.numberOfLines = 2
        layout.font = UIFont(name: "Hiragino Mincho ProN", size: 18)
        layout.textColor = .black
        layout.textAlignment = .left
        return layout
    }()
    
    public lazy var refactor: UILabel = {
        let layout = UILabel()
        layout.numberOfLines = 2
        layout.font = UIFont(name: "Hiragino Mincho ProN", size: 18)
        layout.textColor = .black
        layout.textAlignment = .left
        return layout
        
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
        setupScrollView()
        setupCenterView()
        setupRestaurant()
        setupRestaurantInfo()
        setupHours()
        setupNumberOfMeals()
        setupVenueAddress()
        setupPhoneNumber()
        setupButton()
        setupMap()
        setupGetDirection()
    }
    
    private func setupCenterView() {
        scrollView.addSubview(centerView)
        centerView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            centerView.centerXAnchor.constraint(equalTo: scrollView.centerXAnchor),
            centerView.centerYAnchor.constraint(equalTo: scrollView.centerYAnchor),
            centerView.widthAnchor.constraint(equalTo: scrollView.widthAnchor),
            centerView.heightAnchor.constraint(equalTo: scrollView.heightAnchor)
        ])
    }
    
    private func setupScrollView(){
        addSubview(scrollView)
        scrollView.translatesAutoresizingMaskIntoConstraints = false
        let width = self.bounds.width
        let height = self.bounds.height * 400
        
        NSLayoutConstraint.activate([
            scrollView.centerXAnchor.constraint(equalTo: centerXAnchor),
            scrollView.centerYAnchor.constraint(equalTo: centerYAnchor, constant: -10),
            scrollView.widthAnchor.constraint(equalToConstant: width),
            scrollView.heightAnchor.constraint(equalToConstant: height)
        ])
        
    }
    private func setupRestaurant() { // This is a image
        centerView.addSubview(restaurantPhoto)
        restaurantPhoto.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            restaurantPhoto.centerXAnchor.constraint(equalTo: centerXAnchor),
            restaurantPhoto.centerYAnchor.constraint(equalTo: centerYAnchor),
            restaurantPhoto.heightAnchor.constraint(equalTo: heightAnchor, multiplier: 0.12),
            restaurantPhoto.widthAnchor.constraint(equalTo: widthAnchor, multiplier: 0.12)
        ])
    }
    
    private func setupRestaurantInfo() { // this is a label
        centerView.addSubview(restaurantInfo)
        restaurantInfo.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            restaurantInfo.topAnchor.constraint(equalTo: restaurantPhoto.bottomAnchor, constant: 8),
            restaurantInfo.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 8),
            restaurantInfo.trailingAnchor.constraint(equalTo: trailingAnchor, constant:  -8),
        ])
    }
    
    private func setupHours() { // This is a Label
        centerView.addSubview(hoursOFOperation)
        hoursOFOperation.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            hoursOFOperation.topAnchor.constraint(equalTo: restaurantInfo.bottomAnchor, constant: 8),
            hoursOFOperation.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 8),
            hoursOFOperation.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -8)
        ])
    }
    
    private func setupNumberOfMeals() { // This is a Label
        centerView.addSubview(numberOfMeals)
        numberOfMeals.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            numberOfMeals.topAnchor.constraint(equalTo: hoursOFOperation.bottomAnchor, constant: 8),
            numberOfMeals.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 8),
            numberOfMeals.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -8)
            
        ])
        
    }
    
    private func setupVenueAddress() {
        centerView.addSubview(thisNeedsTobeRefactor)
        thisNeedsTobeRefactor.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            thisNeedsTobeRefactor.topAnchor.constraint(equalTo: numberOfMeals.bottomAnchor, constant: 8),
            thisNeedsTobeRefactor.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 8),
            thisNeedsTobeRefactor.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -8)
            
        ])
    }
    
    
    private func setupPhoneNumber() {
        centerView.addSubview(refactor)
        refactor.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            refactor.topAnchor.constraint(equalTo: thisNeedsTobeRefactor.bottomAnchor, constant:  8),
            refactor.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 8),
            refactor.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -8)
            
        ])
    }
    
    
    private func setupButton() {
        centerView.addSubview(claimButton)
        claimButton.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            claimButton.topAnchor.constraint(equalTo: refactor.bottomAnchor, constant: 8),
            claimButton.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 20),
            claimButton.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -20)
            //                claimButton.centerXAnchor.constraint(equalTo: centerXAnchor),
            //                claimButton.centerYAnchor.constraint(equalTo: centerYAnchor)
            
        ])
    }
    
    private func setupMap() {
        centerView.addSubview(locationMap)
        locationMap.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            locationMap.topAnchor.constraint(equalTo: claimButton.bottomAnchor, constant: 10),
            locationMap.leadingAnchor.constraint(equalTo: safeAreaLayoutGuide.leadingAnchor, constant: 8),
            locationMap.trailingAnchor.constraint(equalTo: safeAreaLayoutGuide.trailingAnchor, constant: -8)
            
        ])
    }
    
    private func setupGetDirection() {
        centerView.addSubview(getDirectionButton)
        getDirectionButton.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            getDirectionButton.topAnchor.constraint(equalTo: locationMap.bottomAnchor, constant: 8),
            getDirectionButton.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 20),
            getDirectionButton.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -20)
            //                getDirectionButton.centerXAnchor.constraint(equalTo: centerXAnchor),
            //                getDirectionButton.centerYAnchor.constraint(equalTo: centerYAnchor)
            
        ])
    }
    
    
}
