//
//  MoreCell.swift
//  VenueTask
//
//  Created by Ibtikar on 14/12/2022.
//

import UIKit

class MoreCell: UITableViewCell {
    @IBOutlet private weak var iconImageView: UIImageView!
    @IBOutlet private weak var titleLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    func setup(item: MoreItem) {
        iconImageView.image = item.icon?.image
        titleLabel.text = item.title
        
    }
}
