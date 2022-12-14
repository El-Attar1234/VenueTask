//
//  VenueCell.swift
//  VenuesTask
//
//  Created by Ibtikar on 13/12/2022.
//

import UIKit

class VenueCell: UITableViewCell {
    @IBOutlet private weak var venueNamelabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    func setup(venue: Venue?) {
        venueNamelabel.text = venue?.name
    }
    
}
