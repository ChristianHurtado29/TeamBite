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
        db.collection(DatabaseService.venuesOwnerCollection).document(authDataResult.user.uid).setData(["name": venue.name, "email": email, "userId": authDataResult.user.uid, "phoneNumber": venue.phoneNumber ?? "", "address": venue.address,"startTime": venue.startTime ?? "" , "endTime": venue.endTime ?? "", "lat": venue.lat, "long": venue.long]){ (error) in
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
        db.collection(DatabaseService.allOffersCollection).document().setData(["offerId": offer.offerId,"nameOfOffer": offer.nameOfOffer, "totalMeals": offer.totalMeals, "remainingMeals": offer.remainingMeals, "startTime": offer.startTime, "endTime": offer.endTime, "allergyType": offer.allergyType ?? "none", "offerImage": offer.offerImage ?? "no url"] ) { (error) in
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
        db.collection(DatabaseService.venuesOwnerCollection).document(venueOwner.uid).collection(DatabaseService.offersCollection).document(offer.offerId).setData(["offerId": offer.offerId,"nameOfOffer": offer.nameOfOffer, "totalMeals": offer.totalMeals, "remainingMeals": offer.remainingMeals, "startTime": offer.startTime, "endTime": offer.endTime, "allergyType": offer.allergyType ?? "none", "offerImage": offer.offerImage ?? "no url", "status": offer.status]) { (error) in
            if let error = error {
                completion(.failure(error))
            } else {
                completion(.success(true))
            }
        }
    }
    
    public func deleteOffer(offer: Offer, completion: @escaping(Result <Bool, Error>) -> ()){
        guard let venueOwner = Auth.auth().currentUser else { return }
        db.collection(DatabaseService.venuesOwnerCollection).document(venueOwner.uid).collection(DatabaseService.offersCollection).document(offer.offerId).delete() {(error) in
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
    
    public func fetchVenue(completion: @escaping (Result< Venue, Error>) -> ()) {
       guard let currentUser = Auth.auth().currentUser else {return}
        
        db.collection(DatabaseService.venuesOwnerCollection).whereField("userId", isEqualTo: currentUser.uid).getDocuments { (snapshot, error) in
            if let error = error {
                completion(.failure(error))
            } else if let snapshot = snapshot {
                let venue = snapshot.documents.compactMap { Venue($0.data()) }
                guard let firstVenue = venue.first else { return }
                completion(.success(firstVenue))
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
    public func fetchVenueOffers(_ venueID: String, completion: @escaping (Result<[Offer], Error>) -> ()) {

        db.collection(DatabaseService.venuesOwnerCollection).document(venueID).collection(DatabaseService.offersCollection).getDocuments { (snapshot, error) in
            if let error = error {
                completion(.failure(error))
            } else if let snapshot = snapshot {
                let offers = snapshot.documents.compactMap { Offer($0.data()) }
                completion(.success(offers))
                dump(offers)
            }
        }
    }
    
    // Performs a transaction. Basically it updates the remaining meals for this offer, but makes certain that it actually updates.
    public func claimOffer(_ venueId: String, _ offerId: String, _ completion: @escaping (Result<Bool,Error>) -> ()) {
        let offerDocRef = db.collection(DatabaseService.venuesOwnerCollection).document(venueId).collection(DatabaseService.offersCollection).document(offerId)
        
        db.runTransaction({ (transaction, errorPointer) -> Any? in
            
            do {
                let sfDocument: DocumentSnapshot // Contains data from a document in firebase.
                try sfDocument = transaction.getDocument(offerDocRef)
                
                guard let oldRemaining = sfDocument.data()?["remainingMeals"] as? Int, oldRemaining > 0 else {
                    let error = NSError(domain: "AppErrorDomain", code: -1, userInfo: [NSLocalizedDescriptionKey : "Either we were unable to retrieve remaining meals from snapshot \(sfDocument.description), or there are no more offers of this meal available. Please try another offer."])
                    errorPointer?.pointee = error
                    return nil
                }

                transaction.updateData(["remainingMeals": oldRemaining - 1], forDocument: offerDocRef)
                
            } catch let fetchError as NSError  {
                errorPointer?.pointee = fetchError
                return nil
            }
            
            return nil
        }) { (object, error) in
            if let error = error {
                completion(.failure(error))
            } else {
                completion(.success(true))
            }
        }
    }
    
    public func forfeitOffer(_ venueId: String, _ offerId: String, _ completion: @escaping (Result<Bool,Error>) -> ()) {
        let offerRef = db.collection(DatabaseService.venuesOwnerCollection).document(venueId).collection(DatabaseService.offersCollection).document(offerId)
        
        db.runTransaction({ (transaction, errorPointer) -> Any? in
            let sfDocument: DocumentSnapshot
            
            do {
                try sfDocument = transaction.getDocument(offerRef)
                
                guard let oldRemaining = sfDocument.data()?["remainingMeals"] as? Int else {
                    let error = NSError(domain: "AppErrorDomain", code: -1, userInfo: [NSLocalizedDescriptionKey: "Unable to retrieve remaining meals from \(sfDocument)"])
                    
                    errorPointer?.pointee = error
                    
                    return nil
                }
                
                transaction.updateData(["remainingMeals": oldRemaining + 1], forDocument: offerRef)
                
            } catch let fetchError as NSError{
                errorPointer?.pointee = fetchError
                return nil
            }
            
            return nil
        }) { (object, error) in
            if let error = error {
                completion(.failure(error))
            } else {
                completion(.success(true))
            }
        }
    }
}
