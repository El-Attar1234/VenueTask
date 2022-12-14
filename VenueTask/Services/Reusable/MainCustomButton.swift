//
//  MainCustomButton.swift
//  VenueTask
//
//  Created by Ibtikar on 14/12/2022.
//

import UIKit

@IBDesignable
class MainCustomButton: UIButton {
    
    override func awakeFromNib() {
        super.awakeFromNib()
        buttonSetting()
   //     setDisable()
    }
    
    private func buttonSetting() {
        self.backgroundColor = Asset.Colors.mainPurple.color
        font(font: .cairoBoldFont(with: 13))
        titleTextColor(.white)
        layer.cornerRadius = 12
    }

}
