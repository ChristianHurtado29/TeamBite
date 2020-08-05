//
//  UserDefaultsHandler.swift
//  TeamBite
//
//  Created by Cameron Rivera on 8/4/20.
//  Copyright © 2020 Christian Hurtado. All rights reserved.
//

import Foundation

struct UserDefaultsHandler {
    
    private let stateKey = "Current Offer State"
    private let offerKey = "Current Offer Name"
    
    static func getAppState() -> String? {
        guard let state = UserDefaults.standard.object(forKey: UserDefaultsHandler().stateKey) as? String else {
            return nil
        }
        return state
    }
    
    static func setStateToClaimed() {
        UserDefaults.standard.set("claimed", forKey: UserDefaultsHandler().stateKey)
    }
    
    static func resetState() {
        UserDefaults.standard.set("unclaimed", forKey: UserDefaultsHandler().stateKey)
    }
    
    static func getOfferName() -> String? {
        guard let name = UserDefaults.standard.object(forKey: UserDefaultsHandler().offerKey) as? String else {
            return nil
        }
        return name
    }
    
    static func saveOfferName(_ name: String) {
        UserDefaults.standard.set(name, forKey: UserDefaultsHandler().offerKey)
    }
    
    static func resetOfferName() {
        UserDefaults.standard.set("", forKey: UserDefaultsHandler().offerKey)
    }
    
}
