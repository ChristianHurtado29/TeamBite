//
//  SignUpViewController.swift
//  TeamBite
//
//  Created by Cameron Rivera on 4/21/20.
//  Copyright © 2020 Christian Hurtado. All rights reserved.
//

import UIKit

enum AccountState {
    case newUser
    case existingUser
}

class VenueSignUpController: UIViewController {

    private let signUpView = VenueSignUpView()
    
    override func loadView(){
        view = signUpView
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setUp()
    }
    
    private func setUp(){
        signUpView.backgroundColor = UIColor.systemBackground
        navigationItem.title = "Sign In"
        signUpView.emailTextField.delegate = self
        signUpView.passwordTextField.delegate = self
        signUpView.signInWithEmailButton.addTarget(self, action: #selector(signInButtonPressed), for: .touchUpInside)
        signUpView.createNewAccountButton.addTarget(self, action: #selector(createAccountButtonPressed), for: .touchUpInside)
    }
    
    @objc
    private func signInButtonPressed(_ sender: UIButton){
        unwrapTextFieldText(AccountState.existingUser)
    }
    
    @objc
    private func createAccountButtonPressed(_ sender: UIButton){
        unwrapTextFieldText(AccountState.newUser)
    }
    
    private func unwrapTextFieldText(_ state: AccountState){
        guard let emailText = signUpView.emailTextField.text, !emailText.isEmpty, let passwordText = signUpView.passwordTextField.text, !passwordText.isEmpty else {
            showAlert(title: "Missing Fields", message: "One or more fields is missing or incorrect.")
            return
        }
        continueLoginFlow(emailText, passwordText, state)
    }
    
    private func continueLoginFlow(_ email: String, _ password: String, _ state: AccountState) {
        if state == AccountState.existingUser{
            FirebaseAuthManager.shared.signInWithEmail(email, password) { [weak self] result in
                switch result{
                case .failure(let error):
                    DispatchQueue.main.async{
                        self?.showAlert(title: "Authentication Error", message: "\(error)")
                    }
                case .success:
//                    let storyboarder = UIStoryboard(name: "Venues", bundle: nil)
//                    guard let venueTabController = storyboarder.instantiateViewController(identifier: "VenueStoryboard") as? UITabBarController else {
//                        fatalError("Could not create instance of UITabBarController")
//                    }
//                    UIViewController.resetWindow(venueTabController)
                    UIViewController.showTabController(storyboardName: "Venues", viewControllerId: "VenueStoryboard", viewController: nil)
                }
            }
        } else if state == AccountState.newUser{
            let collectionVC = CollectVenueInfoController(email, password)
            self.navigationController?.pushViewController(collectionVC, animated: true)
        }
    }

}

extension VenueSignUpController: UITextFieldDelegate{
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        return true
    }
}
