//
//  SignUpView.swift
//  TeamBite
//
//  Created by Cameron Rivera on 4/21/20.
//  Copyright © 2020 Christian Hurtado. All rights reserved.
//

import UIKit

class VenueSignUpView: UIView {

    public var yAnchor = NSLayoutConstraint()
    
    public lazy var biteLogoImageView: UIImageView = {
       let imageView = UIImageView()
        imageView.image = UIImage(named: "BiteLogoUpdated")
        return imageView
    }()
    
    public lazy var emailLabel: UILabel = {
        let label = UILabel()
        label.numberOfLines = 1
        label.textAlignment = .left
        label.textColor = UIColor.black
        label.text = "Email:"
        return label
    }()
    
    public lazy var emailTextField: UITextField = {
        let textField = UITextField()
        textField.placeholder = " Enter email here"
        textField.layer.borderColor = UIColor.black.cgColor
        textField.layer.borderWidth = 1.0
        textField.layer.cornerRadius = 10
        return textField
    }()
    
    public lazy var passwordLabel: UILabel = {
        let label = UILabel()
        label.numberOfLines = 1
        label.textColor = UIColor.black
        label.textAlignment = .left
        label.text = "Password:"
        return label
    }()
    
    public lazy var passwordTextField: UITextField = {
        let textField = UITextField()
        textField.placeholder = " Enter password here"
        textField.isSecureTextEntry = true
        textField.layer.borderColor = UIColor.black.cgColor
        textField.layer.borderWidth = 1.0
        textField.layer.cornerRadius = 10
        return textField
    }()
    
    public lazy var signInWithEmailButton: UIButton = {
       let button = UIButton()
        button.setTitle("Sign in", for: .normal)
        button.setTitleColor(UIColor.blue, for: .normal)
        return button
    }()
    
    public lazy var createNewAccountButton: UIButton = {
        let button = UIButton()
        button.setTitle("Create New Account", for: .normal)
        button.setTitleColor(UIColor.blue, for: .normal)
        return button
    }()
    
    public lazy var buttonStack: UIStackView = {
       let stackView = UIStackView()
        stackView.axis = .vertical
        stackView.distribution = .fillProportionally
        return stackView
    }()
    
    public lazy var tapGesture: UITapGestureRecognizer = {
       let tap = UITapGestureRecognizer()
        return tap
    }()
    
    override init(frame: CGRect) {
        super.init(frame: UIScreen.main.bounds)
        commonInit()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        commonInit()
    }
    
    private func commonInit(){
        setUpBiteLogoConstraints()
        setUpEmailLabelConstraints()
        setUpEmailTextFieldConstraints()
        setUpPasswordLabelConstraints()
        setUpPasswordTextFieldConstraints()
        setUpButtonStackViewConstraints()
        addGestureRecognizer(tapGesture)
    }
    
    private func setUpBiteLogoConstraints(){
        addSubview(biteLogoImageView)
        biteLogoImageView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([ biteLogoImageView.heightAnchor.constraint(equalTo: heightAnchor, multiplier: 0.31), biteLogoImageView.widthAnchor.constraint(equalTo: heightAnchor, multiplier: 0.4), biteLogoImageView.centerXAnchor.constraint(equalTo: centerXAnchor)])
        yAnchor = biteLogoImageView.topAnchor.constraint(equalTo: safeAreaLayoutGuide.topAnchor, constant: 8)
        yAnchor.isActive = true
    }
    
    private func setUpEmailLabelConstraints() {
        addSubview(emailLabel)
        emailLabel.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([emailLabel.topAnchor.constraint(equalTo: biteLogoImageView.bottomAnchor, constant: 30), emailLabel.leadingAnchor.constraint(equalTo: safeAreaLayoutGuide.leadingAnchor, constant: 8), emailLabel.heightAnchor.constraint(equalToConstant: 40)])
    }
    
    private func setUpEmailTextFieldConstraints() {
        addSubview(emailTextField)
        emailTextField.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([emailTextField.topAnchor.constraint(equalTo: biteLogoImageView.bottomAnchor, constant: 30), emailTextField.trailingAnchor.constraint(equalTo: safeAreaLayoutGuide.trailingAnchor, constant: -8), emailTextField.leadingAnchor.constraint(equalTo: emailLabel.trailingAnchor, constant: 40), emailTextField.heightAnchor.constraint(equalToConstant: 40)])
        
        emailLabel.setContentHuggingPriority(.required, for: .horizontal)
    }
    
    private func setUpPasswordLabelConstraints() {
        addSubview(passwordLabel)
        passwordLabel.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([passwordLabel.topAnchor.constraint(equalTo: emailLabel.bottomAnchor, constant: 20), passwordLabel.leadingAnchor.constraint(equalTo: safeAreaLayoutGuide.leadingAnchor, constant: 8), passwordLabel.heightAnchor.constraint(equalToConstant: 40)])
    }
    
    private func setUpPasswordTextFieldConstraints() {
        addSubview(passwordTextField)
        passwordTextField.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([passwordTextField.topAnchor.constraint(equalTo: emailLabel.bottomAnchor, constant: 20), passwordTextField.trailingAnchor.constraint(equalTo: safeAreaLayoutGuide.trailingAnchor, constant: -8), passwordTextField.leadingAnchor.constraint(equalTo: passwordLabel.trailingAnchor, constant: 8), passwordTextField.heightAnchor.constraint(equalToConstant: 40)])
        
        passwordLabel.setContentHuggingPriority(.required, for: .horizontal)
    }
    
    private func setUpButtonStackViewConstraints(){
        addSubview(buttonStack)
        buttonStack.addArrangedSubview(signInWithEmailButton)
        buttonStack.addArrangedSubview(createNewAccountButton)
        buttonStack.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([buttonStack.topAnchor.constraint(equalTo: passwordTextField.bottomAnchor, constant: 50), buttonStack.centerXAnchor.constraint(equalTo: centerXAnchor), buttonStack.heightAnchor.constraint(equalTo: heightAnchor, multiplier: 0.1), buttonStack.widthAnchor.constraint(equalTo: widthAnchor, multiplier: 0.9)])
    }
    
}
