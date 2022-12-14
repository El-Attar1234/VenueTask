//
//  ScenesContainer.swift
//  VenuesTask
//
//  Created by Ibtikar on 13/12/2022.
//

import UIKit

final class AppNavigationController: UINavigationController {}

final class SceneContainer {
    
    class func embedVCInNavController(_ viewController: UIViewController) -> UIViewController {
        let nav = AppNavigationController(rootViewController: viewController)
        return nav
    }
    
    class func getHomeVc() -> HomeVC {
        let viewModel = HomeViewModel()
        let vc = HomeVC(viewModel: viewModel)
        return vc
    }

}
