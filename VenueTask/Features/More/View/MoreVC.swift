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
        let vc: UIViewController
        switch type {
        case .home:
             vc = SceneContainer.getHomeVc()
        case .myProfile:
            vc = SceneContainer.getHomeVc()
            print("profilr")
        case .termsAndConditions:
             vc = SceneContainer.getTermsAndConditions()
            print("terms")
        case .logout:
            vc = SceneContainer.getTermsAndConditions()
//           self.navigationController?.pushViewController(vc, animated: true)
            
            print("\(PersistenceManager.getUserEmail())")
        case .none:
            vc = SceneContainer.getTermsAndConditions()
           self.navigationController?.pushViewController(vc, animated: true)
            print("none")
        }
        if isContained(vc: vc) {
            self.navigationController?.popToViewController(vc, animated: true)
        } else {
            self.navigationController?.pushViewController(vc, animated: true)
        }
    }
}
