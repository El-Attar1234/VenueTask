//
//  AppDelegate+Extension.swift
//  VenueTask
//
//  Created by Ibtikar on 14/12/2022.
//

import Foundation
import IQKeyboardManagerSwift
import GoogleMaps

extension AppDelegate {
    func setupKeyboard() {
        IQKeyboardManager.shared.enable = true
    }
    func setUpGoogleMaps() {
        let googleApiKey = "AIzaSyD_dDqEl_aBLOeb8L4RceUFkZgpU-JySOk"
        GMSServices.provideAPIKey(googleApiKey)
    }
}
