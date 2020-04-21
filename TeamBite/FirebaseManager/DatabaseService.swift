//
//  DatabaseService.swift
//  TeamBite
//
//  Created by Christian Hurtado on 4/20/20.
//  Copyright © 2020 Christian Hurtado. All rights reserved.
//

import Foundation
import FirebaseFirestore
import FirebaseAuth

class DatabaseService {
    static let offeringsCollection = "offerings"
    static let usersCollection = "users"
    private let db = Firestore.firestore()
    
    private init() {}
    static let shared = DatabaseService()
    
    
    public func createUser(authDataResult: AuthDataResult, completion: @escaping (Result<Bool, Error>) -> ()){
        guard let phone = authDataResult.user.phoneNumber else {
            return
        }
        db.collection(DatabaseService.usersCollection)
            .document(authDataResult.user.uid)
            .setData(["phone":phone,
                      "experience": ""]){ (error) in
                        if let error = error {
                            completion(.failure(error))
                        } else {
                            completion(.success(true))
                        }
        }
    }
    
    
    // may not be necessary depending on how initial window will work ---------------------
    
    public func createExperience(experience: String, completion: @escaping (Result<Bool, Error>) -> ()) {
        guard let user = Auth.auth().currentUser else { return }
        db.collection(DatabaseService.usersCollection)
            .document(user.uid).updateData(["experience": experience]) { (error) in
                if let error = error {
                    completion(.failure(error))
                } else {
                    completion(.success(true))
                }
                
        }
    }
    
}
