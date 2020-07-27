//
//  AverageUserSignInView.swift
//  TeamBite
//
//  Created by Cameron Rivera on 4/22/20.
//  Copyright © 2020 Christian Hurtado. All rights reserved.
//

import UIKit

class AverageUserSignInView: UIView {

    public lazy var logoImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.image = UIImage(named: "BiteLogoUpdated")
        return imageView
    }()
    
    public lazy var signInButton: UIButton = {
       let button = UIButton()
        button.setTitle("Sign In", for: .normal)
        button.setTitleColor(UIColor.blue, for: .normal)
        return button
    }()
    
    public lazy var createAccountButton: UIButton = {
        let button = UIButton()
        button.setTitle("Create Account", for: .normal)
        button.setTitleColor(UIColor.blue, for: .normal)
        return button
    }()
    
    public lazy var buttonStackView: UIStackView = {
       let stackView = UIStackView()
        stackView.axis = .vertical
        stackView.distribution = .fillProportionally
        stackView.spacing = 20
        return stackView
    }()
    
    override init(frame: CGRect) {
        super.init(frame: UIScreen.main.bounds)
        commonInit()
    }
    
    required init?(coder: NSCoder){
        super.init(coder: coder)
        commonInit()
    }

    private func commonInit(){
        setUpLogoImageViewConstraints()
        setUpButtonStackConstraints()
    }
    
    private func setUpLogoImageViewConstraints(){
        addSubview(logoImageView)
        logoImageView.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([logoImageView.topAnchor.constraint(equalTo: safeAreaLayoutGuide.topAnchor, constant: 20), logoImageView.heightAnchor.constraint(equalTo: heightAnchor, multiplier: 0.31), logoImageView.widthAnchor.constraint(equalTo: heightAnchor, multiplier: 0.4), logoImageView.centerXAnchor.constraint(equalTo: centerXAnchor) ])
    }
    
    private func setUpButtonStackConstraints(){
        addSubview(buttonStackView)
        buttonStackView.addArrangedSubview(signInButton)
        buttonStackView.addArrangedSubview(createAccountButton)
        buttonStackView.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([buttonStackView.centerYAnchor.constraint(equalTo: centerYAnchor, constant: 30), buttonStackView.centerXAnchor.constraint(equalTo: centerXAnchor), buttonStackView.widthAnchor.constraint(equalTo: widthAnchor, multiplier: 0.35)])
    }
}
