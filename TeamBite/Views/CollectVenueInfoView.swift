//
//  CollectVenueInfoView.swift
//  TeamBite
//
//  Created by Cameron Rivera on 4/21/20.
//  Copyright © 2020 Christian Hurtado. All rights reserved.
//

import UIKit

class CollectVenueInfoView: UIView {

    public lazy var venueNameLabel: UILabel = {
        let label = UILabel()
        label.numberOfLines = 1
        label.textColor = UIColor.black
        label.textAlignment = .left
        label.text = "Venue Name"
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
        textField.placeholder = " Enter Phone Number Here"
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
        label.text = "Street Name"
        return label
    }()
    
    public lazy var streetNameTextField: UITextField = {
       let textField = UITextField()
        textField.placeholder = " Enter street name here"
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
        label.text = "City"
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
        label.text = "State"
        return label
    }()
    
    public lazy var stateTextField: UITextField = {
       let textField = UITextField()
        textField.placeholder = " E.g. NY"
        textField.layer.cornerRadius = 10
        textField.layer.borderColor = UIColor.black.cgColor
        textField.layer.borderWidth = 1.0
        return textField
    }()
    
    public lazy var zipLabel: UILabel = {
        let label = UILabel()
        return label
    }()
    
    public lazy var zipTextField: UITextField = {
        let textField = UITextField()
        return textField
    }()
}
