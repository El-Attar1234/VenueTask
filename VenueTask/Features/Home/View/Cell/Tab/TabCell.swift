//
//  TabCell.swift
//  VenueTask
//
//  Created by Ibtikar on 14/12/2022.
//

import UIKit

class TabCell: UICollectionViewCell {
    @IBOutlet private weak var indicatorView: UIView!
    @IBOutlet private weak var titleLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        indicatorView.isHiddenIfNeeded = true
        // Initialization code
    }
    override var isSelected: Bool {
        didSet {
            if isSelected {
                indicatorView.isHiddenIfNeeded = false
            } else {
                indicatorView.isHiddenIfNeeded = true
            }
           
        }
    }
    func configure(title: String) {
        titleLabel.text = title
    }

}
