//
//  ScenesContainer.swift
//  VenuesTask
//
//  Created by Ibtikar on 13/12/2022.
//

import UIKit
import SideMenu

final class AppNavigationController: UINavigationController {}

final class SceneContainer {
    
    class func embedVCInNavController(_ viewController: UIViewController) -> UIViewController {
        let nav = AppNavigationController(rootViewController: viewController)
        return nav
    }
    class func getSplashVc() -> SplashVC {
        let vc = SplashVC()
        return vc
    }
    class func getHomeVc() -> HomeVC {
        let viewModel = HomeViewModel()
        let vc = HomeVC(viewModel: viewModel)
        return vc
    }
    
    class func openSideMenu() -> SideMenuNavigationController {
        let viewController = getMoreVc()
        let menu = SideMenuNavigationController(rootViewController: viewController)
        menu.leftSide = true
        // menu.sideMenuDelegate = self
       // let width = UIScreen.main.bounds.width - 70
     //   menu.menuWidth = (width - 70)
        
        menu.dismissOnPresent = true
        menu.dismissOnPush = true
       // menu.presentationStyle = .menuSlideIn
        
        let presentationStyle: SideMenuPresentationStyle = .viewSlideOut
        presentationStyle.menuScaleFactor = 0.5
        presentationStyle.presentingScaleFactor = 0.8
        presentationStyle.backgroundColor = Asset.Colors.mainPurple.color
        presentationStyle.menuStartAlpha = 1
        presentationStyle.onTopShadowOpacity = 0.5
        presentationStyle.presentingEndAlpha = 1
        presentationStyle.onTopShadowRadius = 5
        var settings = SideMenuSettings()
        settings.presentationStyle = presentationStyle
        settings.menuWidth = UIScreen.main.bounds.width - 150
        settings.blurEffectStyle = .none
        settings.statusBarEndAlpha = 0
        menu.settings = settings
        return menu
    }

    class func getMoreVc() -> MoreVC {
        let vc = MoreVC()
        return vc
    }
    class func getTermsAndConditions() -> TermsAndConditionsVC {
        let vc = TermsAndConditionsVC()
        return vc
    }
    
    class func getLoginVC() -> LoginVC {
        let vc = LoginVC()
        return vc
    }
    
    class func signUpVC() -> SignUpVC {
        let vc = SignUpVC()
        return vc
    }
}
