//
//  CollectVenueInfoView.swift
//  TeamBite
//
//  Created by Cameron Rivera on 4/21/20.
//  Copyright © 2020 Christian Hurtado. All rights reserved.
//

import UIKit

class CollectVenueInfoView: UIView {
    
    public var yAnchor = NSLayoutConstraint()
    
    public lazy var directionsLabel: UILabel = {
       let label = UILabel()
        label.numberOfLines = 2
        label.textColor = UIColor.black
        label.text = "Please fill in the information below. Required fields are marked with an asterisk."
        label.textAlignment = .center
        return label
    }()

    public lazy var venueNameLabel: UILabel = {
        let label = UILabel()
        label.numberOfLines = 1
        label.textColor = UIColor.black
        label.textAlignment = .left
        label.text = "* Venue Name"
        return label
    }()
    
    public lazy var venueNameTextField: UITextField = {
        let textField = UITextField()
        textField.placeholder = " Enter restaurant name here"
        textField.layer.cornerRadius = 10
        textField.layer.borderColor = UIColor.black.cgColor
        textField.layer.borderWidth = 1.0
        return textField
    }()
    
    public lazy var venuePhoneLabel: UILabel = {
       let label = UILabel()
        label.numberOfLines = 1
        label.textColor = UIColor.black
        label.textAlignment = .left
        label.text = "Phone Number"
        return label
    }()
    
    public lazy var venuePhoneTextField: UITextField = {
       let textField = UITextField()
        textField.placeholder = " Enter phone number here"
        textField.layer.cornerRadius = 10
        textField.layer.borderColor = UIColor.black.cgColor
        textField.layer.borderWidth = 1.0
        return textField
    }()
    
    public lazy var streetNameLabel: UILabel = {
        let label = UILabel()
        label.numberOfLines = 1
        label.textColor = UIColor.black
        label.textAlignment = .left
        label.text = "* Street Address"
        return label
    }()
    
    public lazy var streetNameTextField: UITextField = {
       let textField = UITextField()
        textField.placeholder = " Enter street address here"
        textField.layer.cornerRadius = 10
        textField.layer.borderColor = UIColor.black.cgColor
        textField.layer.borderWidth = 1.0
        return textField
    }()
    
    public lazy var cityLabel: UILabel = {
       let label = UILabel()
        label.numberOfLines = 1
        label.textColor = UIColor.black
        label.textAlignment = .left
        label.text = "* City"
        return label
    }()
    
    public lazy var cityTextField: UITextField = {
       let textField = UITextField()
        textField.placeholder = " Enter city here"
        textField.layer.cornerRadius = 10
        textField.layer.borderColor = UIColor.black.cgColor
        textField.layer.borderWidth = 1.0
        return textField
    }()
    
    public lazy var stateLabel: UILabel = {
        let label = UILabel()
        label.numberOfLines = 1
        label.textColor = UIColor.black
        label.textAlignment = .left
        label.text = "* State"
        return label
    }()
    
    public lazy var stateTextField: UITextField = {
       let textField = UITextField()
        textField.placeholder = " NY"
        textField.layer.cornerRadius = 10
        textField.layer.borderColor = UIColor.black.cgColor
        textField.layer.borderWidth = 1.0
        return textField
    }()
    
    public lazy var zipLabel: UILabel = {
        let label = UILabel()
        label.textColor = UIColor.black
        label.textAlignment = .left
        label.text = "* ZIP"
        label.numberOfLines = 1
        return label
    }()
    
    public lazy var zipTextField: UITextField = {
        let textField = UITextField()
        textField.placeholder = " Enter Zip Code"
        textField.layer.cornerRadius = 10
        textField.layer.borderColor = UIColor.black.cgColor
        textField.layer.borderWidth = 1.0
        return textField
    }()
    
    public lazy var submitButton: UIButton = {
        let button = UIButton()
        button.setTitle("Submit", for: .normal)
        button.setTitleColor(UIColor.blue, for: .normal)
        return button
    }()
    
    public lazy var startTimeLabel: UILabel = {
       let label = UILabel()
        label.numberOfLines = 1
        label.textColor = UIColor.black
        label.textAlignment = .left
        label.text = "Start Time"
        return label
    }()
    
    public lazy var startTimeTextField: UITextField = {
        let textField = UITextField()
        textField.placeholder = " e.g. 12:00"
        textField.layer.cornerRadius = 10
        textField.layer.borderColor = UIColor.black.cgColor
        textField.layer.borderWidth = 1.0
        return textField
    }()
    
    public lazy var endTimeLabel: UILabel = {
       let label = UILabel()
        label.numberOfLines = 1
        label.textColor = UIColor.black
        label.textAlignment = .left
        label.text = "End Time"
        return label
    }()
    
    public lazy var endTimeTextField: UITextField = {
        let textField = UITextField()
        textField.placeholder = " e.g. 1:00"
        textField.layer.cornerRadius = 10
        textField.layer.borderColor = UIColor.black.cgColor
        textField.layer.borderWidth = 1.0
        return textField
    }()
    
    public lazy var startTimeSegmentedControl: UISegmentedControl = {
        let sc = UISegmentedControl()
        sc.insertSegment(withTitle: "A.M.", at: 0, animated: true)
        sc.insertSegment(withTitle: "P.M.", at: 1, animated: true)
        return sc
    }()
    
    public lazy var endTimeSegmentedControl: UISegmentedControl = {
        let sc = UISegmentedControl()
        sc.insertSegment(withTitle: "A.M.", at: 0, animated: true)
        sc.insertSegment(withTitle: "P.M.", at: 1, animated: true)
        return sc
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
        setUpDirectionsLabelConstraints()
        setUpVenueNameLabelConstraints()
        setUpVenueNameTextFieldConstraints()
        setUpVenuePhoneLabelConstraints()
        setUpVenuePhoneTextFieldConstraints()
        setUpStreetLabelConstraints()
        setUpStreetNameTextFieldConstraints()
        setUpCityLabelConstraints()
        setUpCityTextFieldConstraints()
        setUpStateLabelConstraints()
        setUpStateTextFieldConstraints()
        setUpZipLabelConstraints()
        setUpZipTextFieldConstraints()
        setUpStartTimeLabelConstraints()
        setUpStartTimeTextFieldConstraints()
        setUpStartTimeSegmentedControlConstraints()
        setUpEndTimeLabelConstraints()
        setUpEndTimeTextFieldConstraints()
        setUpEndTimeSegmentedControl()
        setUpSubmitButtonConstraints()
        addGestureRecognizer(tapGesture)
    }
    
    private func setUpDirectionsLabelConstraints(){
        addSubview(directionsLabel)
        directionsLabel.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([ directionsLabel.leadingAnchor.constraint(equalTo: safeAreaLayoutGuide.leadingAnchor, constant: 8), directionsLabel.trailingAnchor.constraint(equalTo: safeAreaLayoutGuide.trailingAnchor, constant: -8)])
        yAnchor = directionsLabel.topAnchor.constraint(equalTo: safeAreaLayoutGuide.topAnchor, constant: 20)
        yAnchor.isActive = true
    }
    
    private func setUpVenueNameLabelConstraints(){
        addSubview(venueNameLabel)
        venueNameLabel.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([venueNameLabel.topAnchor.constraint(equalTo: directionsLabel.bottomAnchor, constant: 20), venueNameLabel.leadingAnchor.constraint(equalTo: safeAreaLayoutGuide.leadingAnchor, constant: 8), venueNameLabel.heightAnchor.constraint(equalToConstant: 40)])
    }
    
    private func setUpVenueNameTextFieldConstraints(){
        addSubview(venueNameTextField)
        venueNameTextField.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([venueNameTextField.topAnchor.constraint(equalTo: directionsLabel.bottomAnchor, constant: 20), venueNameTextField.leadingAnchor.constraint(equalTo: venueNameLabel.trailingAnchor, constant: 8), venueNameTextField.trailingAnchor.constraint(equalTo: safeAreaLayoutGuide.trailingAnchor, constant: -8), venueNameTextField.heightAnchor.constraint(equalToConstant: 40)])
        
        venueNameLabel.setContentHuggingPriority(.defaultHigh, for: .horizontal)
    }
    
    private func setUpVenuePhoneLabelConstraints(){
        addSubview(venuePhoneLabel)
        venuePhoneLabel.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([venuePhoneLabel.topAnchor.constraint(equalTo: venueNameLabel.bottomAnchor, constant: 20), venuePhoneLabel.leadingAnchor.constraint(equalTo: safeAreaLayoutGuide.leadingAnchor, constant: 8), venuePhoneLabel.heightAnchor.constraint(equalToConstant: 40)])
    }
    
    private func setUpVenuePhoneTextFieldConstraints(){
        addSubview(venuePhoneTextField)
        venuePhoneTextField.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([venuePhoneTextField.topAnchor.constraint(equalTo: venueNameTextField.bottomAnchor, constant: 20), venuePhoneTextField.leadingAnchor.constraint(equalTo: venuePhoneLabel.trailingAnchor, constant: 8), venuePhoneTextField.trailingAnchor.constraint(equalTo: safeAreaLayoutGuide.trailingAnchor, constant: -8), venuePhoneTextField.heightAnchor.constraint(equalToConstant: 40)])
        
        venuePhoneLabel.setContentHuggingPriority(.defaultHigh, for: .horizontal)
    }
    
    private func setUpStreetLabelConstraints(){
        addSubview(streetNameLabel)
        streetNameLabel.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([streetNameLabel.topAnchor.constraint(equalTo: venuePhoneLabel.bottomAnchor, constant: 20), streetNameLabel.leadingAnchor.constraint(equalTo: safeAreaLayoutGuide.leadingAnchor, constant: 8), streetNameLabel.heightAnchor.constraint(equalToConstant: 40)])
    }
    
    private func setUpStreetNameTextFieldConstraints(){
        addSubview(streetNameTextField)
        streetNameTextField.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([streetNameTextField.topAnchor.constraint(equalTo: venuePhoneTextField.bottomAnchor, constant: 20), streetNameTextField.leadingAnchor.constraint(equalTo: streetNameLabel.trailingAnchor, constant: 8), streetNameTextField.trailingAnchor.constraint(equalTo: safeAreaLayoutGuide.trailingAnchor, constant: -8), streetNameTextField.heightAnchor.constraint(equalToConstant: 40)])
        
        streetNameLabel.setContentHuggingPriority(.defaultHigh, for: .horizontal)
    }
    
    private func setUpCityLabelConstraints(){
        addSubview(cityLabel)
        cityLabel.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([cityLabel.topAnchor.constraint(equalTo: streetNameLabel.bottomAnchor, constant: 20), cityLabel.leadingAnchor.constraint(equalTo: safeAreaLayoutGuide.leadingAnchor, constant: 8), cityLabel.heightAnchor.constraint(equalToConstant: 40)])
    }
    
    private func setUpCityTextFieldConstraints(){
        addSubview(cityTextField)
        cityTextField.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([cityTextField.topAnchor.constraint(equalTo: streetNameTextField.bottomAnchor, constant: 20), cityTextField.leadingAnchor.constraint(equalTo: cityLabel.trailingAnchor, constant: 8), cityTextField.trailingAnchor.constraint(equalToSystemSpacingAfter: safeAreaLayoutGuide.trailingAnchor, multiplier: -8), cityTextField.heightAnchor.constraint(equalToConstant: 40)])
        
        cityLabel.setContentHuggingPriority(.defaultHigh, for: .horizontal)
    }
    
    private func setUpStateLabelConstraints(){
        addSubview(stateLabel)
        stateLabel.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([stateLabel.topAnchor.constraint(equalTo: cityLabel.bottomAnchor, constant: 20), stateLabel.leadingAnchor.constraint(equalTo: safeAreaLayoutGuide.leadingAnchor, constant: 8), stateLabel.heightAnchor.constraint(equalToConstant: 40)])
    }
    
    private func setUpStateTextFieldConstraints(){
        addSubview(stateTextField)
        stateTextField.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([stateTextField.topAnchor.constraint(equalTo: cityTextField.bottomAnchor, constant: 20), stateTextField.leadingAnchor.constraint(equalTo: stateLabel.trailingAnchor, constant: 8), stateTextField.heightAnchor.constraint(equalToConstant: 40), stateTextField.widthAnchor.constraint(equalTo: widthAnchor, multiplier: 0.2)])
        
        stateLabel.setContentHuggingPriority(.defaultHigh, for: .horizontal)
    }
    
    private func setUpZipLabelConstraints(){
        addSubview(zipLabel)
        zipLabel.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([zipLabel.topAnchor.constraint(equalTo: cityTextField.bottomAnchor, constant: 20), zipLabel.leadingAnchor.constraint(equalTo: stateTextField.trailingAnchor, constant: 8), zipLabel.heightAnchor.constraint(equalToConstant: 40)])
        
    }
    
    private func setUpZipTextFieldConstraints(){
        addSubview(zipTextField)
        zipTextField.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([zipTextField.topAnchor.constraint(equalTo: cityTextField.bottomAnchor, constant: 20), zipTextField.leadingAnchor.constraint(equalTo: zipLabel.trailingAnchor, constant: 8), zipTextField.trailingAnchor.constraint(equalTo: safeAreaLayoutGuide.trailingAnchor, constant: -8), zipTextField.heightAnchor.constraint(equalToConstant: 40)])
        
        zipLabel.setContentHuggingPriority(.defaultHigh, for: .horizontal)
    }
    
    private func setUpStartTimeLabelConstraints(){
        addSubview(startTimeLabel)
        startTimeLabel.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([startTimeLabel.topAnchor.constraint(equalTo: zipTextField.bottomAnchor, constant: 20), startTimeLabel.leadingAnchor.constraint(equalTo: safeAreaLayoutGuide.leadingAnchor, constant: 8), startTimeLabel.heightAnchor.constraint(equalToConstant: 40)])
    }
    
    private func setUpStartTimeTextFieldConstraints(){
        addSubview(startTimeTextField)
        startTimeTextField.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([startTimeTextField.topAnchor.constraint(equalTo: zipTextField.bottomAnchor, constant: 20), startTimeTextField.leadingAnchor.constraint(equalTo: startTimeLabel.trailingAnchor, constant: 8), startTimeTextField.widthAnchor.constraint(equalTo: heightAnchor, multiplier: 0.23), startTimeTextField.heightAnchor.constraint(equalToConstant: 40)])
        
        startTimeLabel.setContentHuggingPriority(.defaultHigh, for: .horizontal)
    }
    
    private func setUpStartTimeSegmentedControlConstraints(){
        addSubview(startTimeSegmentedControl)
        startTimeSegmentedControl.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([startTimeSegmentedControl.topAnchor.constraint(equalTo: zipTextField.bottomAnchor, constant: 20), startTimeSegmentedControl.leadingAnchor.constraint(equalTo: startTimeTextField.trailingAnchor, constant: 8)])
    }
    
    private func setUpEndTimeLabelConstraints(){
        addSubview(endTimeLabel)
        endTimeLabel.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([endTimeLabel.topAnchor.constraint(equalTo: startTimeLabel.bottomAnchor, constant: 20), endTimeLabel.leadingAnchor.constraint(equalTo: safeAreaLayoutGuide.leadingAnchor, constant: 8), endTimeLabel.heightAnchor.constraint(equalToConstant: 40)])
    }
    
    private func setUpEndTimeTextFieldConstraints(){
        addSubview(endTimeTextField)
        endTimeTextField.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([endTimeTextField.leadingAnchor.constraint(equalTo: endTimeLabel.trailingAnchor, constant: 15), endTimeTextField.topAnchor.constraint(equalTo: startTimeLabel.bottomAnchor, constant: 20), endTimeTextField.heightAnchor.constraint(equalToConstant: 40), endTimeTextField.widthAnchor.constraint(equalTo: heightAnchor, multiplier: 0.23)])
        endTimeLabel.setContentHuggingPriority(.defaultHigh, for: .horizontal)
    }
    
    private func setUpEndTimeSegmentedControl() {
        addSubview(endTimeSegmentedControl)
        endTimeSegmentedControl.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([endTimeSegmentedControl.topAnchor.constraint(equalTo: startTimeLabel.bottomAnchor, constant: 20), endTimeSegmentedControl.leadingAnchor.constraint(equalTo: endTimeTextField.trailingAnchor, constant: 8)])
    }
    
    private func setUpSubmitButtonConstraints(){
        addSubview(submitButton)
        submitButton.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([submitButton.topAnchor.constraint(equalTo: endTimeTextField.bottomAnchor, constant: 30), submitButton.centerXAnchor.constraint(equalTo: centerXAnchor), submitButton.heightAnchor.constraint(equalToConstant: 44)])
    }
}
