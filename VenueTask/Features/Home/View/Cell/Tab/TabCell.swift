//
//  TabCell.swift
//  VenueTask
//
//  Created by Ibtikar on 14/12/2022.
//

import UIKit

class TabCell: UICollectionViewCell {
    @IBOutlet private weak var backgrounView: UIView!
    @IBOutlet private weak var indicatorView: UIView!
    @IBOutlet private weak var titleLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        indicatorView.isHiddenIfNeeded = true
        backgrounView.backgroundColor = .clear
        // Initialization code
    }
    override var isSelected: Bool {
        didSet {
            if isSelected {
                indicatorView.isHiddenIfNeeded = false
                backgrounView.backgroundColor = Asset.Colors.dimGray.color
            } else {
                indicatorView.isHiddenIfNeeded = true
                backgrounView.backgroundColor = .clear
            }
           
        }
    }
    func configure(title: String) {
        titleLabel.text = title
    }

}
