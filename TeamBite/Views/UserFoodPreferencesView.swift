//
//  UserAllergiesView.swift
//  TeamBite
//
//  Created by Cameron Rivera on 4/22/20.
//  Copyright © 2020 Christian Hurtado. All rights reserved.
//

import UIKit

class UserFoodPreferencesView: UIView {
    
    public lazy var directionsLabel: UILabel = {
       let label = UILabel()
        label.numberOfLines = 2
        label.textColor = UIColor.black
        label.textAlignment = .left
        label.text = "Please specify any dietary preferences you may have."
        return label
    }()
    
    public lazy var nutAllergyLabel: UILabel = {
       let label = UILabel()
        label.numberOfLines = 1
        label.textColor = UIColor.black
        label.textAlignment = .left
        label.text = "Nut-Free"
        return label
    }()
    
    public lazy var nutAllergySwitch: UISwitch = {
       let switches = UISwitch()
        switches.isOn = false
        return switches
    }()
    
    public lazy var glutenFreeLabel: UILabel = {
       let label = UILabel()
        return label
    }()

}
