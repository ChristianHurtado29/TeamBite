//
//  StateHandler.swift
//  TeamBite
//
//  Created by Cameron Rivera on 8/16/20.
//  Copyright © 2020 Christian Hurtado. All rights reserved.
//

import Foundation
import FirebaseAuth

class StateHandler {
    private var timeToNextClaim = Timer()
    static var main = StateHandler()

    private init() {
        
    }
    
    func setTimeToNextClaim(_ timer: Timer) {
        self.timeToNextClaim = timer
    }
    
    func getTimeToNextClaim() -> Timer {
        return timeToNextClaim
    }
    
    @objc
    func updateState() {
        guard let userId = Auth.auth().currentUser?.uid else { return }
        
        DatabaseService.shared.updateStatus(userId, "unclaimed") { (result) in
            switch result {
            case .failure(let error):
                print(error.localizedDescription)
            case .success:
                print("Success")
            }
        }
    }
}
