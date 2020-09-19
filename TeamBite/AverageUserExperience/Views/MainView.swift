//
//  MainView.swift
//  TeamBite
//
//  Created by Margiett Gil on 4/21/20.
//  Copyright © 2020 Christian Hurtado. All rights reserved.
//

import UIKit

class MainView: UIView {
    
    public lazy var collectionView: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .vertical
        let cv = UICollectionView(frame: CGRect.zero, collectionViewLayout: layout)
        cv.backgroundColor = .white
        return cv
    }()
    
    public lazy var viewClaimedOffer: UIBarButtonItem = {
        let barButton = UIBarButtonItem()
        barButton.title = "View Claimed Offer"
        return barButton
    }()
    
    public lazy var signOutButton: UIBarButtonItem = {
       let barButton = UIBarButtonItem()
        barButton.title = "Sign Out"
        return barButton
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
       //  setupLogo()
        setupCollectionVC()
            
    }
//
//    private func setupLogo() {
//        addSubview(logoImage)
//        logoImage.translatesAutoresizingMaskIntoConstraints = false
//        NSLayoutConstraint.activate([
//            logoImage.topAnchor.constraint(equalTo: safeAreaLayoutGuide.topAnchor, constant: 0),
//            logoImage.leadingAnchor.constraint(equalTo: leadingAnchor),
//            logoImage.trailingAnchor.constraint(equalTo: trailingAnchor),
//            logoImage.heightAnchor.constraint(equalTo: heightAnchor, multiplier: 0.10)
//
//        ])
//    }
    
    private func setupCollectionVC(){
        addSubview(collectionView)
        collectionView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            collectionView.topAnchor.constraint(equalTo: safeAreaLayoutGuide.topAnchor),
            collectionView.leadingAnchor.constraint(equalTo: safeAreaLayoutGuide.leadingAnchor),
            collectionView.trailingAnchor.constraint(equalTo: safeAreaLayoutGuide.trailingAnchor),
            collectionView.bottomAnchor.constraint(equalTo: safeAreaLayoutGuide.bottomAnchor)
        ])
    }
    
}
