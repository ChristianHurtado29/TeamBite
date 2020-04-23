//
//  MainView.swift
//  TeamBite
//
//  Created by Margiett Gil on 4/21/20.
//  Copyright © 2020 Christian Hurtado. All rights reserved.
//

import UIKit

class MainView: UIView {
    
    public lazy var logoImage: UIImageView = {
        let image = UIImageView()
        image.image = UIImage(named: "Bite")
        image.contentMode = .scaleAspectFill
        return image
    }()


    
    public lazy var collectionView: UICollectionView = {
        
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .vertical
        let cv = UICollectionView(frame: CGRect.zero, collectionViewLayout: layout)
        cv.backgroundColor = .white
        return cv
    }()
    
       public lazy var filterButton: UIButton = {
       let button = UIButton()
        button.setImage(UIImage(systemName: "into.circle"), for: .normal)
        button.tintColor = #colorLiteral(red: 0.7254902124, green: 0.4784313738, blue: 0.09803921729, alpha: 1)
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
        setupLogo()
        setupCollectionVC()
        //setupButtonVC()
    }
    
    private func setupLogo() {
        addSubview(logoImage)
        logoImage.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            logoImage.topAnchor.constraint(equalTo: safeAreaLayoutGuide.topAnchor, constant: 0),
            logoImage.leadingAnchor.constraint(equalTo: leadingAnchor),
            logoImage.trailingAnchor.constraint(equalTo: trailingAnchor),
            logoImage.heightAnchor.constraint(equalTo: heightAnchor, multiplier: 0.10)
        
        ])
    }
    
    private func setupCollectionVC(){
        addSubview(collectionView)
        collectionView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            collectionView.topAnchor.constraint(equalTo: logoImage.bottomAnchor),
            collectionView.leadingAnchor.constraint(equalTo: safeAreaLayoutGuide.leadingAnchor),
            collectionView.trailingAnchor.constraint(equalTo: safeAreaLayoutGuide.trailingAnchor),
            collectionView.bottomAnchor.constraint(equalTo: safeAreaLayoutGuide.bottomAnchor)
        
        ])
    }
    
    private func setupButtonVC() {
        addSubview(filterButton)
        filterButton.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            filterButton.topAnchor.constraint(equalTo: collectionView.bottomAnchor),
            filterButton.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 8)
        ])
    }
    
    
    
    
    
}
