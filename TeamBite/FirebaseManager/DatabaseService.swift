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
    
    static let offersCollection = "offers"
    static let venuesOwnerCollection = "venues"
    static let usersCollection = "users"
    static let allOffersCollection = "allOffers"
    
    // reference to firebase firestore database
    private let db = Firestore.firestore()
    
    // private init() {}
    static let shared = DatabaseService()
    
    // creates venueOwner
    public func createVenue(venue: Venue, authDataResult: AuthDataResult, completion: @escaping (Result<Bool, Error>) -> ()){
        guard let email = authDataResult.user.email else {return}
        db.collection(DatabaseService.usersCollection).document(authDataResult.user.uid).setData(["email": email, "userId": authDataResult.user.uid, "phoneNumber": venue.phoneNumber ?? "", "address": venue.address,"startTime": venue.startTime ?? "" , "endTime": venue.endTime ?? "", "lat": venue.lat, "long": venue.long]){ (error) in
            if let error = error {
                completion(.failure(error))
            } else {
                completion(.success(true))
            }
        }
    }
    
    
    
    func updateVenue(address: String, phoneNumber: String, completion: @escaping (Result<Bool, Error>) -> ()) {
        
        guard let user = Auth.auth().currentUser else { return }
        
        db.collection(DatabaseService.venuesOwnerCollection).document(user.uid).updateData(["address": address, "phoneNumber": phoneNumber]) { (error) in
            if let error = error {
                completion(.failure(error))
            } else {
                completion(.success(true))
            }
        }
    }
    
    
    
    // create user
    public func createUser(authDataResult: AuthDataResult, completion: @escaping (Result<Bool, Error>) -> ()){
        guard let phone = authDataResult.user.phoneNumber else {return}
        db.collection(DatabaseService.usersCollection).document(authDataResult.user.uid).setData(["phoneNumber":phone,
                                                                                                  "userId": authDataResult.user.uid, ]){ (error) in
                                                                                                    if let error = error {
                                                                                                        completion(.failure(error))
                                                                                                    } else {
                                                                                                        completion(.success(true))
                                                                                                    }
        }
    }
    
    public func createAllOffers(offer: Offer, completion: @escaping(Result<Bool, Error>) -> ()){
        db.collection(DatabaseService.allOffersCollection).document().setData(["offerId": offer.offerId,"nameOfOffer": offer.nameOfOffer, "totalMeals": offer.totalMeals, "remainingMeals": offer.remainingMeals, "startTime": offer.startTime, "endTime": offer.endTime, "allergyType": offer.allergyType ?? "none"]) { (error) in
            if let error = error {
                completion(.failure(error))
            } else {
                completion(.success(true))
            }
        }
    }
    
    
    // Create offers
    public func addToOffers(offer: Offer, completion: @escaping (Result<Bool, Error>) -> ()) {
        guard let venueOwner = Auth.auth().currentUser else { return }
        db.collection(DatabaseService.venuesOwnerCollection).document(venueOwner.uid).collection(DatabaseService.offersCollection).document(offer.offerId).setData(["offerId": offer.offerId,"nameOfOffer": offer.nameOfOffer, "totalMeals": offer.totalMeals, "remainingMeals": offer.remainingMeals, "startTime": offer.startTime, "endTime": offer.endTime, "allergyType": offer.allergyType ?? "none"]) { (error) in
            if let error = error {
                completion(.failure(error))
            } else {
                completion(.success(true))
            }
        }
    }
    
    
    
    public func fetchVenues(completion: @escaping (Result<[Venue], Error>) -> ()) {
        db.collection(DatabaseService.venuesOwnerCollection).getDocuments { (snapshot, error) in
            if let error = error {
                completion(.failure(error))
            } else if let snapshot = snapshot {
                let venues = snapshot.documents.compactMap { Venue($0.data()) }
                completion(.success(venues))
            }
        }
    }
    
    
    
    public func fetchAllOffers(completion: @escaping (Result<[Offer], Error>) -> ()) {
        
        db.collection(DatabaseService.venuesOwnerCollection).document().collection(DatabaseService.offersCollection).getDocuments { (snapshot, error) in
            if let error = error {
                completion(.failure(error))
            } else if let snapshot = snapshot {
                let offers = snapshot.documents.compactMap { Offer($0.data()) }
                completion(.success(offers))
            }
        }
    }
    
    // just removed venueId from completion
    public func fetchVenueOffers(completion: @escaping (Result<[Offer], Error>) -> ()) {
        
        guard let user = Auth.auth().currentUser else { return }
        db.collection(DatabaseService.venuesOwnerCollection).document(user.uid).collection(DatabaseService.offersCollection).getDocuments { (snapshot, error) in
            if let error = error {
                completion(.failure(error))
            } else if let snapshot = snapshot {
                let offers = snapshot.documents.compactMap {Offer($0.data()) }
                completion(.success(offers))
                dump(offers)
            }
        }
    }
    
    
}
