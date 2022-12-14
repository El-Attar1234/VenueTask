//
//  ProfileItemView.swift
//  VenueTask
//
//  Created by Ibtikar on 15/12/2022.
//

import UIKit

@IBDesignable
class ProfileItemView: UIView {
    @IBOutlet private weak var titleLabel: UILabel!
    @IBOutlet private weak var valueLabel: UILabel!
    
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
        let nib = UINib(nibName: ProfileItemView.className, bundle: bundle)
        return nib.instantiate(withOwner: self, options: nil).first as? UIView
    }
    func configureView(title: String, value: String) {
        self.titleLabel.text = title
        self.valueLabel.text = value
    }
}
