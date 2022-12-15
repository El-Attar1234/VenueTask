//
//  VenueCell.swift
//  VenuesTask
//
//  Created by Ibtikar on 13/12/2022.
//

import UIKit

class VenueCell: UITableViewCell {
    @IBOutlet private weak var iconImageView: UIImageView!
    @IBOutlet private weak var venueNamelabel: UILabel!
    @IBOutlet private weak var locationLabel: UILabel!
    @IBOutlet private weak var categoryLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    func setup(venue: Venue?) {
        venueNamelabel.text = venue?.name
        locationLabel.text = venue?.location?.address ?? "" + (venue?.location?.crossStreet ?? "")
        categoryLabel.text = venue?.categories?[0].name
        loadImage(venue: venue)
        
    }
    private func loadImage(venue: Venue?) {
        let prefix = venue?.categories?[0].icon?.iconPrefix ?? ""
        let suffix = venue?.categories?[0].icon?.suffix ?? ""
        let url = prefix + suffix
        iconImageView.loadImageFromUrl(urlString: url,
                                       placeHolderImage: Asset.Images.icNoData.image)
        
    }
    
}
