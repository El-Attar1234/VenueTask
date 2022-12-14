//
//  CustomMapMarkerWindow.swift
//  VenueTask
//
//  Created by Ibtikar on 14/12/2022.
//

import UIKit

@IBDesignable
class CustomMapMarkerWindow: UIView {
    @IBOutlet weak var backgroundView: UIView!
    @IBOutlet private weak var venueNameLabel: UILabel!
    @IBOutlet private weak var venueLocationLabel: UILabel!
    @IBOutlet private weak var venueCategoryLabel: UILabel!
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        commonInit()
    }
    override init(frame: CGRect) {
        super.init(frame: frame)
        commonInit()
    }
    func commonInit() {
        guard let view = loadViewFromNib() else { return }
        view.frame = self.bounds
        self.addSubview(view)
    }
    func loadViewFromNib() -> UIView? {
        let bundle = Bundle(for: type(of: self))
        let nib = UINib(nibName: CustomMapMarkerWindow.className, bundle: bundle)
        return nib.instantiate(withOwner: self, options: nil).first as? UIView
    }
    func setup(venue: Venue?) {
        venueNameLabel.text = venue?.name
        let fullAddress = venue?.location?.address ?? "" + (venue?.location?.crossStreet ?? "")
        venueLocationLabel.text = fullAddress
        venueCategoryLabel.text = venue?.categories?[0].name
        
    }
}
