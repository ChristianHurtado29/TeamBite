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
        db.collection(DatabaseService.usersCollection).document(authDataResult.user.uid).setData(["phone":phone]){ (error) in
            if let error = error {
                completion(.failure(error))
            } else {
                completion(.success(true))
            }
        }
    }
}
