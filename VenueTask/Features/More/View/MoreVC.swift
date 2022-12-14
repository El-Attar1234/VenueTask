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
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {}
}
