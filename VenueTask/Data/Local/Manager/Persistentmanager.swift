//
//  Persistentmanager.swift
//  VenuesTask
//
//  Created by Ibtikar on 13/12/2022.
//

import Foundation

class PersistenceManager {
    
    enum DefaulKeys: String {
        case location = "location"
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
}
