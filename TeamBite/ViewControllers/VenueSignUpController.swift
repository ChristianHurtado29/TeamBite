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
            // TODO: Show an alert indicating that one or more fields is missing, or incorrect.
            return
        }
        continueLoginFlow(emailText, passwordText, state)
    }
    
    private func continueLoginFlow(_ email: String, _ password: String, _ state: AccountState) {
        if state == AccountState.existingUser{
            FirebaseAuthManager.shared.signInWithEmail(email, password) { result in
                switch result{
                case .failure://(let error):
                    print("Authentication Error")
                    // TODO: Show an alert indicating an authentication Error
                    break
                case .success://(let dataResult):
                    //TODO: Fetch user data using data Result
                    //TODO: Change scenes passing in user data.
                    break
                }
            }
        } else if state == AccountState.newUser{
            FirebaseAuthManager.shared.createNewAccountWithEmail(email, password) { result in
                switch result {
                case .failure://(let error):
                    print("Creation Error")
                    // TODO: Display an alert that shows this error
                    break
                case .success://(let authData):
                    print("Successfully created user")
                    // TODO: Prompt the user for more information. Segue to new view controller.
                    break
                }
            }
        }
    }

}

extension VenueSignUpController: UITextFieldDelegate{
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        return true
    }
}
