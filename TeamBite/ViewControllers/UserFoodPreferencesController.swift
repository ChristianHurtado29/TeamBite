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
    }

}
