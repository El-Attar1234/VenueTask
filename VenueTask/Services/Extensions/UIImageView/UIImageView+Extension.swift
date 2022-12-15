//
//  UIImageView+Extension.swift
//  VenueTask
//
//  Created by Ibtikar on 15/12/2022.
//

import Kingfisher

extension UIImageView {
    func loadImageFromUrl(urlString: String,
                          placeHolderImage: UIImage?) {
        
        guard let url = URL(string: urlString) else {
            return
        }
        self.kf.setImage(
            with: url,
            placeholder: placeHolderImage)
    }
}
