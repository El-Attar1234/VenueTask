//
//  SplashVC.swift
//  VenueTask
//
//  Created by Ibtikar on 14/12/2022.
//

import UIKit

class SplashVC: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        DispatchQueue.main.asyncAfter(deadline: .now()) {
            if PersistenceManager.isAuthenticated() {
                let vc = SceneContainer.getHomeVc()
                 self.navigationController?.pushViewController(vc, animated: true)
            } else {
                let vc = SceneContainer.getLoginVC()
                 self.navigationController?.pushViewController(vc, animated: true)
            }
          
        }
    }
}
