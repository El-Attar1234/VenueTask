//
//  LoginVC.swift
//  VenueTask
//
//  Created by Ibtikar on 14/12/2022.
//

import UIKit

class LoginVC: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.navigationController?.navigationBar.isHidden = true
    }

    @IBAction func signUpAction(_ sender: Any) {
        let signUpVC = SceneContainer.signUpVC()
        self.navigationController?.pushViewController(signUpVC, animated: true)
    }
    
}
