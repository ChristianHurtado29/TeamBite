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

// Create a user collection to save state to.
// Remember to change state from UserDefaults.
// Add the ability to select add a picture to the cell. 
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
    public func createUser(_ patron: User, completion: @escaping (Result<Bool, Error>) -> ()){
        db.collection(DatabaseService.usersCollection).document(patron.userId).setData(["phoneNumber":patron.phoneNumber ,"userId": patron.userId, "allergies": patron.allergies, "claimStatus": patron.claimStatus]){ (error) in
            if let error = error {
                completion(.failure(error))
            } else {
                completion(.success(true))
            }
        }
    }
    
    // Checks to see if current user already exists
    public func doesAccountExist(_ userId: String, _ completion: @escaping ((Result<Bool,Error>) -> ())) {
        db.collection(DatabaseService.usersCollection).whereField("userId", isEqualTo: userId).getDocuments { (snapshot, error) in
            if let error = error {
                completion(.failure(error))
            } else if let snap = snapshot {
                if snap.documents.count > 0 {
                    completion(.success(true))
                } else {
                    completion(.success(false))
                }
            }
        }
    }
    
    // Update the status of the user.
    public func updateStatus(_ userId: String, _ status: String, _ completion: @escaping ((Result<Bool, Error>) -> ())) {
        db.collection(DatabaseService.usersCollection).document(userId).updateData(["claimStatus": status]) { (error) in
            if let error = error {
                completion(.failure(error))
            } else {
                completion(.success(true))
            }
        }
    }
    
    public func fetchUserStatus(_ userId: String, _ completion: @escaping (Result<String,Error>) -> ()) {
        db.collection(DatabaseService.usersCollection).document(userId).getDocument { (snapshot, error) in
            if let error = error {
                completion(.failure(error))
            } else if let snap = snapshot, let data = snap.data() {
                let currentUser = User(data)
                completion(.success(currentUser.claimStatus))
            }
        }
    }
    
    public func createAllOffers(offer: Offer, completion: @escaping(Result<Bool, Error>) -> ()){
        db.collection(DatabaseService.allOffersCollection).document().setData(["offerId": offer.offerId,"nameOfOffer": offer.nameOfOffer, "totalMeals": offer.totalMeals, "remainingMeals": offer.remainingMeals, "startTime": offer.startTime, "endTime": offer.endTime, "allergyType": offer.allergyType ?? "none", "expectedIds": offer.expectedIds]) { (error) in
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
        db.collection(DatabaseService.venuesOwnerCollection).document(venueOwner.uid).collection(DatabaseService.offersCollection).document(offer.offerId).setData(["offerId": offer.offerId,"nameOfOffer": offer.nameOfOffer, "totalMeals": offer.totalMeals, "remainingMeals": offer.remainingMeals, "startTime": offer.startTime, "endTime": offer.endTime, "allergyType": offer.allergyType ?? "none", "expectedIds": offer.expectedIds]) { (error) in
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
            }
        }
    }
    
    // Searchs for and removes the userId from an offers array.
    // NOTE: Might not need this
    public func isValidOffer(_ userId: String, _ venueId: String, _ offerId: String, _ completion: @escaping (Result<Bool,Error>) -> ()) {
        db.collection(DatabaseService.venuesOwnerCollection).document(venueId).collection(DatabaseService.offersCollection).document(offerId).getDocument { [weak self] (snapshot, error) in
            if let error = error {
                completion(.failure(error))
            } else if let snaps = snapshot, var ids = snaps.data()?["expectedIds"] as? [String], let idIndex = ids.firstIndex(of: userId) {
                ids.remove(at: idIndex)
                self?.updateOffer(venueId, offerId, ids) { result in
                    switch result {
                    case .failure(let error):
                        completion(.failure(error))
                    case .success:
                        completion(.success(true))
                    }
                }
            }
        }
    }
    
    // Updates an offer
    // NOTE: May not need this.
    public func updateOffer(_ venueId: String, _ offerId: String, _ newIds: [String], _ completion: @escaping (Result<Bool, Error>) -> ()){
        db.collection(DatabaseService.venuesOwnerCollection).document(venueId).collection(DatabaseService.offersCollection).document(offerId).updateData(["expectedIds": newIds]) { (error) in
            if let error = error {
                completion(.failure(error))
            } else {
                completion(.success(true))
            }
        }
    }
    
    // Update Transation. Combines isValidOffer and updateOffer
    public func updateOfferTransaction(_ userId: String, _ venueId: String, _ offerId: String, _ completion: @escaping (Result<Bool,Error>) -> ()) {
        
        let dbReference = db.collection(DatabaseService.venuesOwnerCollection).document(venueId).collection(DatabaseService.offersCollection).document(offerId)
        
        db.runTransaction({ (transaction, errorPointer) -> Any? in
            
            do {
                let sfDocument: DocumentSnapshot
                
                try sfDocument = transaction.getDocument(dbReference)
                
                guard var oldIds = sfDocument.data()?["expectedIds"] as? [String], let foundIndex = oldIds.firstIndex(of: userId) else {
                    let error = NSError(domain: "AppErrorDomain", code: -1, userInfo: [NSLocalizedDescriptionKey: "Unable to retrieve expected Ids."])
                    errorPointer?.pointee = error
                    return nil
                }
                
                oldIds.remove(at: foundIndex)
                
                transaction.updateData(["expectedIds": oldIds], forDocument: dbReference)
                
            } catch let error as NSError {
                errorPointer?.pointee = error
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
    
    // Performs a transaction. Basically it updates the remaining meals for this offer, but makes certain that it actually updates.
    public func claimOffer(_ venueId: String, _ offerId: String, _ userId: String, _ completion: @escaping (Result<Bool,Error>) -> ()) {
        let offerDocRef = db.collection(DatabaseService.venuesOwnerCollection).document(venueId).collection(DatabaseService.offersCollection).document(offerId)
        
        db.runTransaction({ (transaction, errorPointer) -> Any? in
            
            do {
                let sfDocument: DocumentSnapshot // Contains data from a document in firebase.
                try sfDocument = transaction.getDocument(offerDocRef)
                
                guard let oldRemaining = sfDocument.data()?["remainingMeals"] as? Int, var expIds = sfDocument.data()?["expectedIds"] as? [String], oldRemaining > 0 else {
                    let error = NSError(domain: "AppErrorDomain", code: -1, userInfo: [NSLocalizedDescriptionKey : "Either we were unable to retrieve remaining meals from snapshot \(sfDocument.description), or there are no more offers of this meal available. Please try another offer."])
                    errorPointer?.pointee = error
                    return nil
                }
                
                if !expIds.contains(userId) {
                    expIds.append(userId)
                }
                
                transaction.updateData(["remainingMeals": oldRemaining - 1, "expectedIds": expIds], forDocument: offerDocRef)
                
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
    
    public func forfeitOffer(_ venueId: String, _ offerId: String, _ userId: String, _ completion: @escaping (Result<Bool,Error>) -> ()) {
        let offerRef = db.collection(DatabaseService.venuesOwnerCollection).document(venueId).collection(DatabaseService.offersCollection).document(offerId)
        
        db.runTransaction({ (transaction, errorPointer) -> Any? in
            let sfDocument: DocumentSnapshot
            
            do {
                try sfDocument = transaction.getDocument(offerRef)
                
                guard let oldRemaining = sfDocument.data()?["remainingMeals"] as? Int, var expIds = sfDocument.data()? ["expectedIds"] as? [String] else {
                    let error = NSError(domain: "AppErrorDomain", code: -1, userInfo: [NSLocalizedDescriptionKey: "Unable to retrieve remaining meals from \(sfDocument)"])
                    
                    errorPointer?.pointee = error
                    
                    return nil
                }
                
                if let userIdIndex = expIds.firstIndex(of: userId){
                    expIds.remove(at: userIdIndex)
                }
                transaction.updateData(["remainingMeals": oldRemaining + 1, "expectedIds": expIds], forDocument: offerRef)
                
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
