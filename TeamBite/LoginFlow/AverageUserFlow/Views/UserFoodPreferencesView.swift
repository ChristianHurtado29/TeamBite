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
        label.textAlignment = .center
        label.font = UIFont.preferredFont(forTextStyle: .title1)
        label.text = "Please specify any dietary preferences you may have."
        return label
    }()
    
    public lazy var nutAllergyLabel: UILabel = {
       let label = UILabel()
        label.numberOfLines = 1
        label.textColor = UIColor.black
        label.textAlignment = .left
        label.text = "Nut Free"
        label.font = UIFont(name: "Arial", size: 20)
        return label
    }()
    
    public lazy var nutAllergySwitch: UISwitch = {
       let switches = UISwitch()
        switches.isOn = false
        return switches
    }()
    
    public lazy var glutenFreeLabel: UILabel = {
       let label = UILabel()
        label.numberOfLines = 1
        label.textColor = UIColor.black
        label.textAlignment = .left
        label.text = "Gluten Free"
        label.font = UIFont(name: "Arial", size: 20)
        return label
    }()
    
    public lazy var glutenFreeSwitch: UISwitch = {
       let switches = UISwitch()
        switches.isOn = false
        return switches
    }()
    
    public lazy var vegetarianLabel: UILabel = {
        let label = UILabel()
        label.numberOfLines = 1
        label.textColor = UIColor.black
        label.textAlignment = .left
        label.text = "Vegetarian"
        label.font = UIFont(name: "Arial", size: 20)
        return label
    }()
    
    public lazy var vegetarianSwitch: UISwitch = {
        let switches = UISwitch()
        switches.isOn = false
        return switches
    }()
    
    public lazy var submitButton: UIButton = {
        let button = UIButton()
        button.setTitle("Submit", for: .normal)
        button.setTitleColor(UIColor.blue, for: .normal)
        return button
    }()
    
    override init(frame: CGRect){
        super.init(frame: UIScreen.main.bounds)
        commonInit()
    }
    
    required init?(coder: NSCoder){
        super.init(coder: coder)
        commonInit()
    }
    
    private func commonInit(){
        setUpDirectionsLabelConstraints()
        setUpNutAllergyLabelConstraints()
        setUpNutAllergySwitchConstraints()
        setUpGlutenFreeLabelConstraints()
        setUpGlutenFreeSwitchConstraints()
        setUpVegetarianLabelConstraints()
        setUpVegetarianSwitchConstraints()
        setUpSubmitButtonConstraints()
    }
    
    private func setUpDirectionsLabelConstraints(){
        addSubview(directionsLabel)
        directionsLabel.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([directionsLabel.topAnchor.constraint(equalTo: safeAreaLayoutGuide.topAnchor, constant: 20), directionsLabel.leadingAnchor.constraint(equalTo: safeAreaLayoutGuide.leadingAnchor, constant: 8), directionsLabel.trailingAnchor.constraint(equalTo: safeAreaLayoutGuide.trailingAnchor, constant: -8)])
    }
    
    private func setUpNutAllergyLabelConstraints(){
        addSubview(nutAllergyLabel)
        nutAllergyLabel.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([nutAllergyLabel.topAnchor.constraint(equalTo: directionsLabel.bottomAnchor, constant: 30), nutAllergyLabel.leadingAnchor.constraint(equalTo: safeAreaLayoutGuide.leadingAnchor, constant: 8), nutAllergyLabel.heightAnchor.constraint(equalToConstant: 44)])
    }
    
    private func setUpNutAllergySwitchConstraints(){
        addSubview(nutAllergySwitch)
        nutAllergySwitch.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([nutAllergySwitch.topAnchor.constraint(equalTo: directionsLabel.bottomAnchor, constant: 38), nutAllergySwitch.trailingAnchor.constraint(equalTo: safeAreaLayoutGuide.trailingAnchor, constant: -8), nutAllergySwitch.leadingAnchor.constraint(equalTo: nutAllergyLabel.trailingAnchor, constant: 8), nutAllergySwitch.heightAnchor.constraint(equalToConstant: 44)])
        nutAllergySwitch.setContentHuggingPriority(.defaultHigh, for: .horizontal)
    }
    
    private func setUpGlutenFreeLabelConstraints(){
        addSubview(glutenFreeLabel)
        glutenFreeLabel.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([glutenFreeLabel.topAnchor.constraint(equalTo: nutAllergyLabel.bottomAnchor, constant: 20), glutenFreeLabel.leadingAnchor.constraint(equalTo: safeAreaLayoutGuide.leadingAnchor, constant: 8), glutenFreeLabel.heightAnchor.constraint(equalToConstant: 44)])
    }
    
    private func setUpGlutenFreeSwitchConstraints(){
        addSubview(glutenFreeSwitch)
        glutenFreeSwitch.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([glutenFreeSwitch.topAnchor.constraint(equalTo: nutAllergySwitch.bottomAnchor, constant: 20), glutenFreeSwitch.trailingAnchor.constraint(equalTo: safeAreaLayoutGuide.trailingAnchor, constant: -8), glutenFreeSwitch.leadingAnchor.constraint(equalTo: glutenFreeLabel.trailingAnchor, constant: 8), glutenFreeSwitch.heightAnchor.constraint(equalToConstant: 44)])
        glutenFreeSwitch.setContentHuggingPriority(.defaultHigh, for: .horizontal)
    }
    
    private func setUpVegetarianLabelConstraints(){
        addSubview(vegetarianLabel)
        vegetarianLabel.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([vegetarianLabel.topAnchor.constraint(equalTo: glutenFreeLabel.bottomAnchor, constant: 20), vegetarianLabel.leadingAnchor.constraint(equalTo: safeAreaLayoutGuide.leadingAnchor, constant: 8), vegetarianLabel.heightAnchor.constraint(equalToConstant: 44)])
    }
    
    private func setUpVegetarianSwitchConstraints(){
        addSubview(vegetarianSwitch)
        vegetarianSwitch.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([vegetarianSwitch.topAnchor.constraint(equalTo: glutenFreeSwitch.bottomAnchor, constant: 20), vegetarianSwitch.leadingAnchor.constraint(equalTo: vegetarianLabel.trailingAnchor, constant: 8), vegetarianSwitch.trailingAnchor.constraint(equalTo: safeAreaLayoutGuide.trailingAnchor, constant: -8)])
        vegetarianSwitch.setContentHuggingPriority(.defaultHigh, for: .horizontal)
    }
    
    private func setUpSubmitButtonConstraints(){
        addSubview(submitButton)
        submitButton.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([submitButton.topAnchor.constraint(equalTo: vegetarianLabel.bottomAnchor, constant: 30), submitButton.centerXAnchor.constraint(equalTo: centerXAnchor)])
    }

}
