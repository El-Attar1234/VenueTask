//
//  UIFont+Extension.swift
//  VenuesTask
//
//  Created by Ibtikar on 13/12/2022.
//

import UIKit

extension UIFont {
    
    static func mainFontMedium(of size: CGFloat) -> UIFont {
        return UIFont.systemFont(ofSize: size, weight: .medium)
    }
    
    static func mainFontRegular(of size: CGFloat) -> UIFont {
        return UIFont.systemFont(ofSize: size, weight: .regular)
    }
    
    static func cairoBoldFont(with size: CGFloat) -> UIFont {
        let font = UIFont(name: FontFamily.Cairo.bold.name, size: size)
        guard let myfont = font else { return mainFontMedium(of: size) }
        return myfont
    }
    static func cairoSemiBoldFont(with size: CGFloat) -> UIFont {
        let font = UIFont(name: FontFamily.Cairo.semiBold.name, size: size)
        guard let myfont = font else { return mainFontMedium(of: size) }
        return myfont
    }
    
}

enum FontWeightType: String {
    case bold
    case medium
}
