//
//  AverageUserSignInController.swift
//  TeamBite
//
//  Created by Cameron Rivera on 4/22/20.
//  Copyright © 2020 Christian Hurtado. All rights reserved.
//

import UIKit

class AverageUserSignInController: UIViewController {

    private let userLoginView = AverageUserSignInView()
    
    override func loadView(){
        view = userLoginView
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setUp()
    }
    
    private func setUp(){
        userLoginView.backgroundColor = UIColor.systemBackground
        navigationItem.title = "Login"
        userLoginView.signInButton.addTarget(self, action: #selector(signInButtonPressed), for: .touchUpInside)
        userLoginView.createAccountButton.addTarget(self, action: #selector(createNewAccountButtonPressed), for: .touchUpInside)
    }
    
    @objc
    private func signInButtonPressed(_ sender: UIButton){
        let loginWithPhoneVC = LoginWithPhoneController()
        navigationController?.pushViewController(loginWithPhoneVC, animated: true)
    }
    
    @objc
    private func createNewAccountButtonPressed(_ sender: UIButton){
        let allergiesVC = UserFoodPreferencesController()
        navigationController?.pushViewController(allergiesVC, animated: true)
    }

}
