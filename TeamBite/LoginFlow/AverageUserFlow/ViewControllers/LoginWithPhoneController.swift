//
//  LoginWithPhoneController.swift
//  TeamBite
//
//  Created by Cameron Rivera on 4/22/20.
//  Copyright © 2020 Christian Hurtado. All rights reserved.
//

import UIKit
import FirebaseAuth

class LoginWithPhoneController: UIViewController {
    
    private let loginWithPhoneView = LoginWithPhoneView()
    private let dietaryPreferences: [String]?
    private var agreedToText = false
    private let alertText = """
    Using phone notifications means you agree to receiving a text message from this service, which may or may not incur some charge depending on your service. Do you accept these terms?
"""
    
    init(_ dietaryPreferences: [String]? = nil){
        self.dietaryPreferences = dietaryPreferences
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func loadView(){
        view = loginWithPhoneView
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setUp()
        loginWithPhoneView.tapGesture.addTarget(self, action: #selector(dismissKeyboard))
    }
    
    private func setUp(){
        loginWithPhoneView.backgroundColor = UIColor.systemBackground
        navigationItem.title = "Enter Phone Number"
        loginWithPhoneView.submitButton.addTarget(self, action: #selector(submitButtonPressed), for: .touchUpInside)
    }
    
    @objc
    private func submitButtonPressed(_ sender: UIButton){
        guard let phoneNumber = loginWithPhoneView.phoneNumberTextField.text, !phoneNumber.isEmpty, areYouPhoneNumberCompliant(phoneNumber), phoneNumber.count >= 7 else {
            showAlert(title: "Format Error", message: "Phone number is incorrectly formatted.")
            return
        }
        let verificationPhoneNumber = "+1" + phoneNumber
        if !agreedToText {
            showAnAlert(verificationPhoneNumber)
        } else {
            verify(verificationPhoneNumber)
        }
    }
    
    private func verify(_ phoneNumber: String){
        PhoneAuthProvider.provider().verifyPhoneNumber(phoneNumber, uiDelegate: nil) { [weak self] (verificationID, error) in
            if let error = error {
                self?.showAlert(title: "Error", message: "Could not verify phone Number: \(error)")
                return
            } else if let verificationID = verificationID {
                // TODO: Create User Instance and push to firebase
                self?.promptUserForVerificationCode(verificationID)
            }
        }
    }
    
    private func promptUserForVerificationCode(_ verification: String){
        let verificationAlert = UIAlertController(title: "Enter Code", message: "Enter the code you received from the text message", preferredStyle: .alert)
        verificationAlert.addTextField()
        
        guard let textField = verificationAlert.textFields?.first else {
            return
        }
        
        let submitAlertAction = UIAlertAction(title: "Submit", style: .default) { [weak self] alertAction in
            let credential = PhoneAuthProvider.provider().credential(withVerificationID: verification, verificationCode: textField.text ?? "")
            self?.signIn(credential)
        }
        verificationAlert.addAction(submitAlertAction)
        present(verificationAlert, animated: true)
    }
    
    private func signIn(_ credential: PhoneAuthCredential){
        FirebaseAuthManager.shared.signInWith(credential: credential) { [weak self] result in
            switch result {
            case .failure(let error):
                self?.showAlert(title: "Authentication Error", message: "Could not sign into firebase with provided credential: \(error) ")
            case .success(let authResult):
//                let storyborder = UIStoryboard(name: "Wireframe", bundle: nil)
//                guard let userTabBarController = storyborder.instantiateViewController(identifier: "UserTabBarController") as? UITabBarController else {
//                    fatalError("Could not instantiate view controller")
//                }
//                UIViewController.resetWindow(userTabBarController)
                if let prefs = self?.dietaryPreferences {
                    self?.doesNewUserExist(authResult, prefs)
                } else {
                    let tabBarController = TabBarController()
                    UIViewController.resetWindow(tabBarController)
                }
            }
        }
    }
    
    private func showAnAlert(_ phoneNumber: String){
        let alertController = UIAlertController(title: "Notification", message: alertText, preferredStyle: .alert)
        let yesAction = UIAlertAction(title: "Yes", style: .default) { [weak self] action in
            self?.agreedToText = true
            self?.verify(phoneNumber)
        }
        let noAction = UIAlertAction(title: "No", style: .default, handler: nil)
        alertController.addAction(yesAction)
        alertController.addAction(noAction)
        present(alertController, animated: true, completion: nil)
    }
    
    private func areYouPhoneNumberCompliant(_ phoneNum: String) -> Bool{
        
        for element in phoneNum{
            if !element.isWholeNumber && !element.isWhitespace && element != "+"{
                return false
            }
        }
        
        return true
    }
    
    private func createNewUser(_ authResult: AuthDataResult, _ prefs: [String]) {
        let newUser = User(userId: authResult.user.uid, phoneNumber: authResult.user.phoneNumber ?? "None", allergies: prefs, claimStatus: "unclaimed")
        DatabaseService.shared.createUser(newUser) { [weak self] (result) in
            switch result {
            case .failure(let error):
                self?.showAlert(title: "Error", message: "Could not add user information to database: \(error.localizedDescription)")
            case .success:
                let tabBarController = TabBarController()
                UIViewController.resetWindow(tabBarController)
            }
        }
    }
    
    private func doesNewUserExist(_ authResult: AuthDataResult, _ prefs: [String]) {
        DatabaseService.shared.doesAccountExist(authResult.user.uid) { [weak self] (result) in
            switch result {
            case .failure(let error):
                self?.showAlert(title: "Error", message: "Could not verify the existence of user: \(error.localizedDescription)")
            case .success(let isAUser):
                print("IS A USER: \(isAUser)")
                if isAUser {
                    let tabBarController = TabBarController()
                    UIViewController.resetWindow(tabBarController)
                } else {
                    self?.createNewUser(authResult, prefs)
                }
            }
        }
    }
    
    @objc
    private func dismissKeyboard(_ gesture: UITapGestureRecognizer){
        loginWithPhoneView.phoneNumberTextField.resignFirstResponder()
    }
}
