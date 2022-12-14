//
//  MoreDataService.swift
//  VenueTask
//
//  Created by Ibtikar on 14/12/2022.
//

import Foundation

enum MoreTypes {
    case home
    case myProfile
    case termsAndConditions
    case logout
}

struct MoreItem {
    var icon: ImageAsset?
    var title: String?
    var type: MoreTypes?
}

class MoreDataService {
    
    private static let home = MoreItem(icon: Asset.Images.rightArrow, title: "Home", type: .home)
    private static let myProfile = MoreItem(icon: Asset.Images.rightArrow, title: "My Profile", type: .myProfile)
    private static let terms = MoreItem(icon: Asset.Images.rightArrow,
                                        title: "Terms & Conditions",
                                        type: .termsAndConditions)
    private static let logout = MoreItem(icon: Asset.Images.logout, title: "Log Out", type: .logout)
    
    static func getMoreItems() -> [MoreItem] {
        let items = [home, myProfile, terms, logout]
        return items
    }
}
