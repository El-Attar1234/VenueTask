//
//  Environment.swift
//  VenuesTask
//
//  Created by Ibtikar on 13/12/2022.
//

import Foundation

public enum Environment {
    // MARK: - Keys
    enum Keys {
        enum Plist {
            static let baseURL = "BASE_URL"
            static let clientID = "CLIENT_ID"
            static let clientSecret = "CLIENT_SECRET"
            // swiftlint:disable identifier_name
            static let V = "V"
        }
    }
    
    // MARK: - Plist
    private static let infoDictionary: [String: Any] = {
        guard let dict = Bundle.main.infoDictionary else {
            fatalError("Plist file not found")
        }
        return dict
    }()
    
    // MARK: - Plist values
    static let baseURL: URL = {
        guard let rootURLstring = Environment.infoDictionary[Keys.Plist.baseURL] as? String else {
            fatalError("Base URL not set in plist for this environment")
        }
        guard let url = URL(string: rootURLstring) else {
            fatalError("Base URL is invalid")
        }
        return url
    }()
    
    static let clientID: String = {
        guard let rootURLstring = Environment.infoDictionary[Keys.Plist.clientID] as? String else {
            fatalError("clientID not set in plist for this environment")
        }
        
        return rootURLstring
    }()
    
    static let clientSecret: String = {
        guard let rootURLstring = Environment.infoDictionary[Keys.Plist.clientSecret] as? String else {
            fatalError("clientSecret not set in plist for this environment")
        }
        
        return rootURLstring
    }()
    // swiftlint:disable identifier_name
    static let v: String = {
        guard let rootURLstring = Environment.infoDictionary[Keys.Plist.V] as? String else {
            fatalError("v URL not set in plist for this environment")
        }
        
        return rootURLstring
    }()
}
