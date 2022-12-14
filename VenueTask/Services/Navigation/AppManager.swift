//
//  AppManager.swift
//  VenuesTask
//
//  Created by Ibtikar on 13/12/2022.
//

import UIKit

final class AppManager {
    
    static var shared: AppManager = AppManager()
    private(set) var window: UIWindow?
    
    private init() {
    }
    
    func initWindow(_ window: UIWindow? = UIWindow(frame: UIScreen.main.bounds)) {
        self.window = window
        window?.rootViewController = SceneContainer.embedVCInNavController(SceneContainer.getSplashVc())
        window?.makeKeyAndVisible()
        
    }
    
    func setRootView(viewController: UIViewController) {
        window?.rootViewController = viewController
        
    }
    func logout() {
        PersistenceManager.clearDefalts()
        let vc = SceneContainer.embedVCInNavController(SceneContainer.getLoginVC())
        setRootView(viewController: vc)
    }
}
