//
//  UIButton+Extension.swift
//  VenueTask
//
//  Created by Ibtikar on 14/12/2022.
//

import UIKit

extension UIButton {
    
    func font(font: UIFont) {
        titleLabel?.font = font
    }
    func titleText(_ value: String) {
         self.setTitle(value, for: .normal)
    }
    
    func titleTextColor(_ value: UIColor) {
        self.setTitleColor(value, for: .normal)
    }
    
    func border( color: UIColor, thickness: CGFloat) {
        self.borderColor = color
        self.borderWidth = thickness
    }
    
}

