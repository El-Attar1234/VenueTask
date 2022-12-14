//
//  File.swift
//  VenueTask
//
//  Created by Ibtikar on 14/12/2022.
//

import UIKit

extension UINavigationBar {
    
    // MARK: - for ios 13
    func transparentNavigationBar() {
        self.setBackgroundImage(UIImage(), for: .default)
        self.shadowImage = UIImage()
        self.isTranslucent = true
    }
}
