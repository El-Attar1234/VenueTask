//
//  MoreVC.swift
//  VenueTask
//
//  Created by Ibtikar on 14/12/2022.
//

import UIKit

class MoreVC: UIViewController {
    @IBOutlet private weak var moreTableView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupScreenDesign()
    }
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.navigationController?.navigationBar.isHidden = true
    }
    
    private func setupScreenDesign() {
        moreTableView.dataSource = self
        moreTableView.delegate = self
        moreTableView.register(cellType: MoreCell.self)
    }
    func isContained<V: UIViewController>(vc: V) -> Bool {
        self.navigationController?.viewControllers.contains(vc) ?? false
    }

}

extension MoreVC: UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return MoreDataService.getMoreItems().count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(with: MoreCell.self, for: indexPath)
        let item = MoreDataService.getMoreItems()[indexPath.item]
        cell.setup(item: item)
        return cell
    }
}

extension MoreVC: UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let type = MoreDataService.getMoreItems()[indexPath.item].type

        switch type {
        case .home:
            homeItemSelected()
        case .myProfile:
            myProfileItemSelected()
        case .termsAndConditions:
           termsItemSelected()
        case .logout:
            logoutItemSelected()
        case .none:
            print("none")
        }
    }
}

// MARK: - Navigation
extension MoreVC {
    
    func homeItemSelected() {
        let viewControllers = self.navigationController?.viewControllers ?? []
        for vc in viewControllers where vc is HomeVC {
            self.navigationController?.popToViewController(vc, animated: true)
            return
        }
        let vc = SceneContainer.getHomeVc()
        self.navigationController?.pushViewController(vc, animated: true)
    }
    
    func myProfileItemSelected() {
        let viewControllers = self.navigationController?.viewControllers ?? []
        for vc in viewControllers where vc is MyProfileVC {
            self.navigationController?.popToViewController(vc, animated: true)
            return
        }
        let vc = SceneContainer.getMyProfile()
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
    func logoutItemSelected() {
        PersistenceManager.clearDefalts()
        let vc = SceneContainer.embedVCInNavController(SceneContainer.getLoginVC())
        AppManager.shared.setRootView(viewController: vc)
    }
}
