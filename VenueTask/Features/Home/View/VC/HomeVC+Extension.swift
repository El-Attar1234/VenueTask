//
//  HomeVC+Extension.swift
//  VenuesTask
//
//  Created by Ibtikar on 13/12/2022.
//
import UIKit

extension HomeVC: UITableViewDataSource, UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewModel.getVenuesCount()
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(with: VenueCell.self,
                                                 for: indexPath)
        let venue = viewModel.getVenue(item: indexPath.item)
        cell.setup(venue: venue)
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return   UITableView.automaticDimension
    }
   
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        goToLocation()
    }
    
}
