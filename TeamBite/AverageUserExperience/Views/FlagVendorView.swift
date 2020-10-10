//
//  FlagVendorView.swift
//  TeamBite
//
//  Created by Cameron Rivera on 10/4/20.
//  Copyright © 2020 Christian Hurtado. All rights reserved.
//

import UIKit

class FlagVendorView: UIView {

    public lazy var venueNameLabel: UILabel = {
       let label = UILabel()
        label.text = "Venue Name:"
        return label
    }()
    
    public lazy var venueNameTextField: PaddedTextField = {
       let textField = PaddedTextField()
        textField.isUserInteractionEnabled = false
        textField.layer.borderWidth = 0.7
        textField.layer.borderColor = UIColor.black.cgColor
        textField.layer.cornerRadius = 10.0
        return textField
    }()
    
    public lazy var reasonForFlagLabel: UILabel = {
       let label = UILabel()
        label.text = "Reason for Flag:"
        return label
    }()
    
    public lazy var expandOnReasonLabel: UILabel = {
        let label = UILabel()
        label.text = "Please explain your reason for flagging below"
        label.textAlignment = .left
        label.textColor = UIColor.black
        label.alpha = 0.0
        return label
    }()
    
    public lazy var reasonForFlagTextField: PaddedTextField = {
        let textField = PaddedTextField()
        textField.placeholder = "Select reason for flagging"
        textField.layer.borderWidth = 0.7
        textField.layer.borderColor = UIColor.black.cgColor
        textField.layer.cornerRadius = 10.0
        return textField
    }()
    
    public lazy var reasonForFlagTextView: UITextView = {
        let textView = UITextView()
        textView.alpha = 0.0
        textView.layer.borderWidth = 0.7
        textView.layer.borderColor = UIColor.black.cgColor
        textView.layer.cornerRadius = 10.0
        return textView
    }()
    
    public lazy var submitButton: UIButton = {
        let button = UIButton()
        button.setTitle("Submit", for: .normal)
        button.setTitleColor(UIColor.white, for: .normal)
        button.backgroundColor = #colorLiteral(red: 0.8078431487, green: 0.02745098062, blue: 0.3333333433, alpha: 1)
        button.titleLabel?.font = UIFont.systemFont(ofSize: 15, weight: UIFont.Weight.semibold)
        return button
    }()
    
    public lazy var tapGesture: UITapGestureRecognizer = {
        let tap = UITapGestureRecognizer()
        return tap
    }()
    
    override init(frame: CGRect) {
        super.init(frame: CGRect(x: 0.0, y: 0.0, width: UIScreen.main.bounds.size.width, height: UIScreen.main.bounds.size.height * 0.5))
        commonInit()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        commonInit()
    }
    
    private func commonInit() {
        configureVenueNameLabelConstraints()
        configureVenueNameTextFieldConstraints()
        configureReasonForFlagLabelConstraints()
        configureReasonForFlagTextFieldConstraints()
        configureExpandOnReasonLabelConstraints()
        configureReasonForFlagTextViewConstraints()
        configureSubmitButtonConstraints()
        addGestureRecognizer(tapGesture)
        backgroundColor = UIColor.systemBackground
    }
    
    private func configureVenueNameLabelConstraints() {
        addSubview(venueNameLabel)
        venueNameLabel.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([venueNameLabel.topAnchor.constraint(equalTo: safeAreaLayoutGuide.topAnchor, constant: 10), venueNameLabel.leadingAnchor.constraint(equalTo: safeAreaLayoutGuide.leadingAnchor, constant: 13), venueNameLabel.trailingAnchor.constraint(equalTo: safeAreaLayoutGuide.trailingAnchor, constant: -8)])
    }
    
    private func configureVenueNameTextFieldConstraints() {
        addSubview(venueNameTextField)
        venueNameTextField.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([venueNameTextField.topAnchor.constraint(equalTo: venueNameLabel.bottomAnchor, constant: 8), venueNameTextField.leadingAnchor.constraint(equalTo: safeAreaLayoutGuide.leadingAnchor, constant: 8), venueNameTextField.trailingAnchor.constraint(equalTo: safeAreaLayoutGuide.trailingAnchor, constant: -8), venueNameTextField.heightAnchor.constraint(equalToConstant: 50.0)])
    }
    
    private func configureReasonForFlagLabelConstraints() {
        addSubview(reasonForFlagLabel)
        reasonForFlagLabel.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([reasonForFlagLabel.topAnchor.constraint(equalTo: venueNameTextField.bottomAnchor, constant: 20), reasonForFlagLabel.leadingAnchor.constraint(equalTo: safeAreaLayoutGuide.leadingAnchor, constant: 13), reasonForFlagLabel.trailingAnchor.constraint(equalTo: safeAreaLayoutGuide.trailingAnchor, constant: -8)])
    }
    
    private func configureReasonForFlagTextFieldConstraints() {
        addSubview(reasonForFlagTextField)
        reasonForFlagTextField.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([reasonForFlagTextField.topAnchor.constraint(equalTo: reasonForFlagLabel.bottomAnchor, constant: 8), reasonForFlagTextField.leadingAnchor.constraint(equalTo: safeAreaLayoutGuide.leadingAnchor, constant: 8), reasonForFlagTextField.trailingAnchor.constraint(equalTo: safeAreaLayoutGuide.trailingAnchor, constant: -8), reasonForFlagTextField.heightAnchor.constraint(equalToConstant: 50.0)])
    }
    
    private func configureExpandOnReasonLabelConstraints() {
        addSubview(expandOnReasonLabel)
        expandOnReasonLabel.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([expandOnReasonLabel.topAnchor.constraint(equalTo: reasonForFlagTextField.bottomAnchor, constant: 20), expandOnReasonLabel.leadingAnchor.constraint(equalTo: safeAreaLayoutGuide.leadingAnchor, constant: 8), expandOnReasonLabel.trailingAnchor.constraint(equalTo: safeAreaLayoutGuide.trailingAnchor, constant: -8)])
    }
    
    private func configureReasonForFlagTextViewConstraints() {
        addSubview(reasonForFlagTextView)
        reasonForFlagTextView.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([reasonForFlagTextView.topAnchor.constraint(equalTo: expandOnReasonLabel.bottomAnchor, constant: 8), reasonForFlagTextView.leadingAnchor.constraint(equalTo: safeAreaLayoutGuide.leadingAnchor, constant: 8), reasonForFlagTextView.trailingAnchor.constraint(equalTo: safeAreaLayoutGuide.trailingAnchor, constant: -8), reasonForFlagTextView.heightAnchor.constraint(equalTo: heightAnchor, multiplier: 0.3)])
    }
    
    private func configureSubmitButtonConstraints() {
        addSubview(submitButton)
        submitButton.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([submitButton.topAnchor.constraint(equalTo: reasonForFlagTextField.bottomAnchor, constant: 32), submitButton.leadingAnchor.constraint(equalTo: safeAreaLayoutGuide.leadingAnchor, constant: 8), submitButton.trailingAnchor.constraint(equalTo: safeAreaLayoutGuide.trailingAnchor, constant: -8), submitButton.heightAnchor.constraint(equalToConstant: 50.0)])
    }
}
