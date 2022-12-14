//
//  Persistentmanager.swift
//  VenuesTask
//
//  Created by Ibtikar on 13/12/2022.
//

import Foundation

class PersistenceManager {
    
    enum DefaulKeys: String, CaseIterable{
        case location = "location"
        case email = "email"
        case authentication = "Authentication"
    }
    
    static func save(value: UserLocation) {
        let encoder = JSONEncoder()
        if let encoded = try? encoder.encode(value) {
            UserDefaults.standard.set(encoded, forKey: DefaulKeys.location.rawValue)
        }
    }
    
    static func getUserLocation() -> UserLocation? {
        let defaults = UserDefaults.standard
        if let savedLocation = defaults.object(forKey: DefaulKeys.location.rawValue) as? Data {
            let decoder = JSONDecoder()
            if let savedLocation = try? decoder.decode(UserLocation.self, from: savedLocation) {
                return savedLocation
            }
        }
        return nil
    }
    
    static func save(email: String) {
        UserDefaults.standard.set(email, forKey: DefaulKeys.email.rawValue)
    }
    static func getUserEmail() -> String? {
        UserDefaults.standard.object(forKey: DefaulKeys.email.rawValue) as? String
    }
    static func authenticated(value: Bool) {
        UserDefaults.standard.set(value, forKey: DefaulKeys.authentication.rawValue)
 
    }
    
    static func isAuthenticated() -> Bool {
        return  UserDefaults.standard.bool(forKey: DefaulKeys.authentication.rawValue)
    }
    static func clearDefalts() {
        DefaulKeys.allCases.forEach { UserDefaults.standard.removeObject(forKey: $0.rawValue) }
    }
}
