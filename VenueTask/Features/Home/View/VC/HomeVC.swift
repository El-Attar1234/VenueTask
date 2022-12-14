//
//  HomeVC.swift
//  VenuesTask
//
//  Created by Ibtikar on 13/12/2022.
//

import UIKit
import CoreLocation
import GoogleMaps

class HomeVC: BaseVC {
   
    @IBOutlet private weak var mapView: GMSMapView!
    @IBOutlet private weak var venuesTableView: UITableView!
    // MARK: - Private Variables
    private let cLocationManager = CLLocationManager()
    weak var viewModel: HomeViewModelProtocol!
    
    init(viewModel: HomeViewModelProtocol) {
        super.init(baseViewModel: viewModel)
        self.viewModel = viewModel
        
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        setUpTableView()
        setupBinding()
        setUpLocationManager()
    }
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        viewModel.viewWillAppear()
       
    }
    func setupBinding() {
        viewModel.onSuccessFetching = { [weak self] in
            guard let self else { return }
            self.venuesTableView.reloadData()
        }
    }
    private func setUpTableView() {
        venuesTableView.dataSource = self
        venuesTableView.delegate   = self
        venuesTableView.register(cellType: VenueCell.self)
    }
    private func setUpLocationManager() {
      //  mapView.delegate = self
        cLocationManager.delegate = self
        cLocationManager.desiredAccuracy = kCLLocationAccuracyBest
        locationAuthStatus()
            
        }
        func locationAuthStatus() {
            switch cLocationManager.authorizationStatus {
            case .notDetermined:
                cLocationManager.requestWhenInUseAuthorization()
            case .restricted, .denied:
                print("denied")
//                    self.hideLoadingIndicator()
//                   setUpLocationDeniedCase()
            case .authorizedAlways, .authorizedWhenInUse:
                print("Access") // go to map
                cLocationManager.startUpdatingLocation()
            @unknown default:
                break
            }
        }
        
}

extension HomeVC: CLLocationManagerDelegate {
    
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
      //  self.showLoadingIndicator()
        guard let location: CLLocation = locations.last else {
            return
        }

        let latitude = location.coordinate.latitude
        let longitude = location.coordinate.longitude
        let userLocation = UserLocation(latitude: latitude, longitude: longitude)
        PersistenceManager.save(value: userLocation)
        print("Lat \(latitude)")
        print("Long \(longitude)")

        cLocationManager.stopUpdatingLocation()
    }

    func locationManager(_ manager: CLLocationManager, didChangeAuthorization status: CLAuthorizationStatus) {
        locationAuthStatus()
    }
}

extension HomeVC: GMSMapViewDelegate {
    func goToLocation(){

          let camera = GMSCameraPosition.camera(withLatitude: 30 , longitude: 31 , zoom: 8)
          
          mapView.camera = camera
          
      }
    func mapView(_ mapView: GMSMapView, idleAt position: GMSCameraPosition) {
           
           let position = CLLocationCoordinate2D(latitude: 30, longitude: 31)
           
           let marker = GMSMarker(position: position)
           
           marker.map = self.mapView
       }
    
}
