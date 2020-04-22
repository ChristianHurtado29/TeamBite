//
//  UserAllergiesViewController.swift
//  TeamBite
//
//  Created by Cameron Rivera on 4/22/20.
//  Copyright © 2020 Christian Hurtado. All rights reserved.
//

import UIKit

class UserFoodPreferencesController: UIViewController {

    private let allergiesView = UserFoodPreferencesView()
    
    override func loadView(){
        view = allergiesView
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setUp()
    }
    
    private func setUp(){
        allergiesView.backgroundColor = UIColor.systemBackground
    }

}
