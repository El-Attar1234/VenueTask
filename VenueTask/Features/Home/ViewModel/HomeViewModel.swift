//
//  HomeViewModel.swift
//  VenuesTask
//
//  Created by Ibtikar on 13/12/2022.
//

import Foundation
protocol HomeViewModelProtocol: AnyObject, BaseViewModelProtocol {
    // MARK: - ViewLifeCycle
    func viewWillAppear()
    // MARK: - Observables
    var onSuccessFetching: (() -> Void)? { get set }
    func getVenuesCount() -> Int
    func getTabsT() -> [String]
    func getVenue(item: Int) -> Venue?
    
}
class HomeViewModel: BaseViewModel, HomeViewModelProtocol {
    // MARK: - Observables
    var onSuccessFetching: (() -> Void)?

    // MARK: - Properties
    private  var homeRepo: HomeRepositoryProtocol!
    var venues: [Venue] = []
    var tabsTitles = ["ListView", "GoogleMap"]
    
    init(homeRepo: HomeRepositoryProtocol = HomeRepository()) {
        self.homeRepo = homeRepo
    }
    
    func viewWillAppear() {
        fetchVenues()
    }
    
    func getVenuesCount() -> Int {
        venues.count
    }
    
    func getVenue(item: Int) -> Venue? {
        venues[item]
    }
    func getTabsT() -> [String] {
        tabsTitles
    }
}
extension HomeViewModel {
    func fetchVenues() {
        self.showLoader?()
        if let savedLocation = PersistenceManager.getUserLocation(),
           let lat = savedLocation.latitude,
           let long = savedLocation.longitude {
            homeRepo.fetchVenues(latLong: "\(lat),\(long)") { [weak self] (response, _) in
                guard let self = self else { return }
                self.hideLoader?()
                switch response {
                case .success(let res):
                    self.venues = res?.response?.venues ?? []
                    self.onSuccessFetching?()
                case .failure(let error):
                    switch error {
                    case .serverResponseError:
                        print("server")
                    case .notConnected:
                        print("Not Conected")
                    case .clientError:
                        print("Client Error")
                    case .unauthorized:
                        print("Unauthorized")
                    default:
                        print("Default")
                    }
                    
                }
                
            }
        } else {
            self.hideLoader?()
            self.showMessage?("Can't fetch userLocation", .error)
        }
       
    }
}
