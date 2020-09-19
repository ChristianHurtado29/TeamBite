//
//  AuthenticationSessions.swift
//  TeamBite
//
//  Created by Christian Hurtado on 4/20/20.
//  Copyright © 2020 Christian Hurtado. All rights reserved.
//

import UIKit
import FirebaseAuth

class FirebaseAuthManager{
    static let shared = FirebaseAuthManager()
    private var authRef = Auth.auth()
    
    private init() {}
    
    public func signInWithEmail(_ email: String, _ password: String, completion: @escaping (Result<AuthDataResult,Error>) -> ()){
        
        authRef.signIn(withEmail: email, password: password) { (dataResult, error) in
            if let error = error {
                completion(.failure(error))
            } else if let dataResult = dataResult {
                completion(.success(dataResult))
            }
        }
        
    }
    
    public func createNewAccountWithEmail(_ email: String, _ password: String, completion: @escaping (Result<AuthDataResult,Error>) -> ()){
        
        authRef.createUser(withEmail: email, password: password) { (dataResult, error) in
            if let error = error {
                completion(.failure(error))
            } else if let dataResult = dataResult {
                completion(.success(dataResult))
            }
        }
    }
    
    public func signInWith(credential: PhoneAuthCredential, completion: @escaping (Result<AuthDataResult,Error>) -> ()){
        authRef.signIn(with: credential) { (authResult, error) in
            if let error = error {
                completion(.failure(error))
            } else if let authResult = authResult {
                completion(.success(authResult))
            }
        }
    }
    
    public func signOut(_ controller: UIViewController) {
        do {
            try Auth.auth().signOut()
            if let window = SceneHelper.window {
                window.rootViewController = UINavigationController(rootViewController: LoginViewController())
            }
        } catch {
            DispatchQueue.main.async {
                controller.showAlert(title: "Error", message: "Could not sign out of account: \(error.localizedDescription)")
            }
        }
    }
}
