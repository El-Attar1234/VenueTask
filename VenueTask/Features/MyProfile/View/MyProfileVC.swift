//
//  MyProfileVC.swift
//  VenueTask
//
//  Created by Ibtikar on 15/12/2022.
//

import UIKit
import SideMenu

class MyProfileVC: BaseVC {
    @IBOutlet private weak var profileStackView: UIStackView!
    let profileItems = MyOwnProfileItems.allItems
    weak var viewModel: MyProfileViewModelProtocol!
    var menu: SideMenuNavigationController?
    
    init(viewModel: MyProfileViewModelProtocol) {
        super.init(baseViewModel: viewModel)
        self.viewModel = viewModel
        
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupBindings()
        viewModel.viewDidLoad()
    }
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        setUpNavBar()
        addMenuButton()
    }
    func setupBindings() {
        viewModel.onSuccessFetching = {[weak self] user in
            guard let self else { return }
            self.fillContent(user: user)
            
        }
    }
    func fillContent(user: User) {
        profileStackView.removeAllArrangedSubviews()
        for (index, item) in profileItems.enumerated() {
            let view = ProfileItemView()
            profileStackView.insertArrangedSubview(view, at: index)
            switch item {
            case .fullName:
                let fullname = (user.firstName ?? "") + " " + (user.lastName ?? "")
                view.configureView(title: item.title(), value: fullname)
            case .age:
                view.configureView(title: item.title(), value: user.age ?? "")
            case .email:
                view.configureView(title: item.title(), value: user.email ?? "")
           
            }
        }
    }
    func addMenuButton() {
        let leftBarButtonItem = UIBarButtonItem(
            image: Asset.Images.icMenu.image,
            style: .plain,
            target: self,
            action: #selector(mainMenuTapped))
        self.navigationItem.leftBarButtonItem = leftBarButtonItem
        self.navigationItem.leftBarButtonItem?.tintColor = Asset.Colors.mainPurple.color
    }
    @objc
    func mainMenuTapped() {
         menu = SceneContainer.openSideMenu(menuDelegate: self)
        menu?.sideMenuDelegate = self
        if let menu {
            self.present(menu, animated: true)
        }
    }
}

extension MyProfileVC: SideMenuNavigationControllerDelegate {
    
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
extension MyProfileVC: SidemenuClassdelegate {
    func itemClicked(type: MoreTypes) {
        menu?.dismiss(animated: true)
        menu = nil
        switch type {
        case .home:
            homeItemSelected()
        case .myProfile:
            print("profile is current")
        case .termsAndConditions:
            print("terms is current")
        case .logout:
            AppManager.shared.logout()
        }
    }
    func homeItemSelected() {
        let viewControllers = self.navigationController?.viewControllers ?? []
        for vc in viewControllers where vc is HomeVC {
            self.navigationController?.popToViewController(vc, animated: true)
            return
        }
        let vc = SceneContainer.getHomeVc()
        self.navigationController?.pushViewController(vc, animated: true)
    }

    func termsItemSelected() {
        let viewControllers = self.navigationController?.viewControllers ?? []
        for vc in viewControllers where vc is TermsAndConditionsVC {
            self.navigationController?.popToViewController(vc, animated: true)
            return
        }
        let vc = SceneContainer.getTermsAndConditions()
        self.navigationController?.pushViewController(vc, animated: true)
    }

}
