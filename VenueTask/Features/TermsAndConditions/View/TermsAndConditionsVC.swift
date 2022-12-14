//
//  TermsAndConditionsVC.swift
//  VenueTask
//
//  Created by Ibtikar on 14/12/2022.
//

import UIKit
import SideMenu

class TermsAndConditionsVC: UIViewController {
    
    private var overlayView = UIView()

    override func viewDidLoad() {
        super.viewDidLoad()
        // overlay creation
        overlayView.backgroundColor = .black
        overlayView.alpha = 0.47
        overlayView.translatesAutoresizingMaskIntoConstraints = false

        // Do any additional setup after loading the view.
    }
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        setUpNavBar()
    }
    func setUpNavBar() {
        
        self.navigationController?.navigationBar.isHidden = false
        self.navigationController?.navigationBar.backItem?.title = ""
        self.navigationController?.navigationBar.topItem?.backButtonTitle = ""
     //   self.navigationController?.navigationBar.transparentNavigationBar()
        
        let leftBarButtonItem = UIBarButtonItem(
            image: Asset.Images.icMenu.image,
            style: .plain,
            target: self,
            action: #selector(mainMenuTapped))
        
        self.navigationItem.leftBarButtonItem = leftBarButtonItem
        self.navigationItem.rightBarButtonItem?.tintColor = .white
        self.navigationItem.leftBarButtonItem?.tintColor = Asset.Colors.mainPurple.color
    }
    @objc
    func mainMenuTapped() {
        let menu = SceneContainer.openSideMenu()
        menu.sideMenuDelegate = self
        self.present(menu, animated: true)
    }
}

extension TermsAndConditionsVC: SideMenuNavigationControllerDelegate {
    
    func sideMenuWillAppear(menu: SideMenuNavigationController, animated: Bool) {
        if let viewToInsertIn = self.view {
            viewToInsertIn.insertSubview(overlayView, at: viewToInsertIn.subviews.count)
            overlayView.leadingAnchor.constraint(equalTo: viewToInsertIn.leadingAnchor).isActive = true
            overlayView.trailingAnchor.constraint(equalTo: viewToInsertIn.trailingAnchor).isActive = true
            overlayView.topAnchor.constraint(equalTo: viewToInsertIn.topAnchor).isActive = true
            overlayView.bottomAnchor.constraint(equalTo: viewToInsertIn.bottomAnchor).isActive = true
        }
    }

    func sideMenuWillDisappear(menu: SideMenuNavigationController, animated: Bool) {
        UIView.animate(withDuration: 1.0, animations: {
            self.overlayView.removeFromSuperview()
        }, completion: {_ in
            self.overlayView.removeFromSuperview()
        })
    }
 
}
