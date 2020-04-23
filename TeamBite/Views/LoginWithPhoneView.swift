//
//  LoginWithPhoneView.swift
//  TeamBite
//
//  Created by Cameron Rivera on 4/22/20.
//  Copyright © 2020 Christian Hurtado. All rights reserved.
//

import UIKit

class LoginWithPhoneView: UIView {

    public lazy var phoneLabel: UILabel = {
       let label = UILabel()
        label.numberOfLines = 1
        label.textAlignment = .left
        label.textColor = UIColor.black
        label.text = "Phone Number"
        return label
    }()
    
    public lazy var phoneNumberTextField: UITextField = {
       let textField = UITextField()
        textField.layer.cornerRadius = 10
        textField.layer.borderColor = UIColor.black.cgColor
        textField.layer.borderWidth = 1.0
        textField.placeholder = " E.g. 5555555555"
        return textField
    }()
    
    public lazy var submitButton: UIButton = {
       let button = UIButton()
        button.setTitle("Submit", for: .normal)
        button.setTitleColor(UIColor.blue, for: .normal)
        return button
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
        setUpPhoneLabelConstraints()
        setUpPhoneTextFieldConstraints()
        setUpSubmitButtonConstraints()
    }

    private func setUpPhoneLabelConstraints(){
        addSubview(phoneLabel)
        phoneLabel.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([phoneLabel.topAnchor.constraint(equalTo: safeAreaLayoutGuide.topAnchor, constant: 20), phoneLabel.leadingAnchor.constraint(equalTo: safeAreaLayoutGuide.leadingAnchor, constant: 8), phoneLabel.heightAnchor.constraint(equalToConstant: 40)])
    }

    private func setUpPhoneTextFieldConstraints(){
        addSubview(phoneNumberTextField)
        phoneNumberTextField.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([phoneNumberTextField.topAnchor.constraint(equalTo: safeAreaLayoutGuide.topAnchor, constant: 20), phoneNumberTextField.trailingAnchor.constraint(equalTo: safeAreaLayoutGuide.trailingAnchor, constant: -8), phoneNumberTextField.leadingAnchor.constraint(equalTo: phoneLabel.trailingAnchor, constant: 8), phoneNumberTextField.heightAnchor.constraint(equalToConstant: 40)])
        phoneLabel.setContentHuggingPriority(.defaultHigh, for: .horizontal)
    }
    
    private func setUpSubmitButtonConstraints(){
        addSubview(submitButton)
        submitButton.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([submitButton.topAnchor.constraint(equalTo: phoneNumberTextField.bottomAnchor, constant: 20), submitButton.centerXAnchor.constraint(equalTo: centerXAnchor)])
    }
}
