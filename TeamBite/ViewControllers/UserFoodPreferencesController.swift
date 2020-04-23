//
//  UserAllergiesViewController.swift
//  TeamBite
//
//  Created by Cameron Rivera on 4/22/20.
//  Copyright © 2020 Christian Hurtado. All rights reserved.
//

import UIKit

class UserFoodPreferencesController: UIViewController {

    private let preferencesView = UserFoodPreferencesView()
    
    override func loadView(){
        view = preferencesView
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setUp()
    }
    
    private func setUp(){
        preferencesView.backgroundColor = UIColor.systemBackground
        navigationItem.title = "Food Preferences"
        preferencesView.submitButton.addTarget(self, action: #selector(submitButtonPressed), for: .touchUpInside)
    }
    
    @objc
    private func submitButtonPressed(_ sender: UIButton){
        var dietaryPrefs = [String]()
        
        if preferencesView.nutAllergySwitch.isOn{
            dietaryPrefs.append("Nut-Free")
        }
        
        if preferencesView.glutenFreeSwitch.isOn{
            dietaryPrefs.append("Gluten Free")
        }
        
        if preferencesView.vegetarianSwitch.isOn{
            dietaryPrefs.append("Vegetarian")
        }
        
        let phoneLoginVC = LoginWithPhoneController(dietaryPrefs)
        navigationController?.pushViewController(phoneLoginVC, animated: true)
    }

}
