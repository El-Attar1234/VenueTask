//
//  HomeVC.swift
//  VenuesTask
//
//  Created by Ibtikar on 13/12/2022.
//

import UIKit
import CoreLocation
import GoogleMaps

enum ViewType: Int {
    case listView = 0
    case googleMaps
}

class HomeVC: BaseVC {
   
    @IBOutlet private weak var tabsCollectionView: UICollectionView! {
        didSet {
            tabsCollectionView.dataSource = self
            tabsCollectionView.delegate   = self
            tabsCollectionView.register(cellType: TabCell.self)
        }
    }
    @IBOutlet private weak var mapView: GMSMapView!
    @IBOutlet private weak var venuesTableView: UITableView!
    
    // MARK: - Variables
    private let cLocationManager = CLLocationManager()
    weak var viewModel: HomeViewModelProtocol!
    var tabsTitles = ["ListView", "GoogleMap"]
    var viewtype: ViewType = .listView {
        didSet {
            switch viewtype {
            case .listView:
                venuesTableView.isHiddenIfNeeded = false
                mapView.isHiddenIfNeeded = true
            case .googleMaps:
                venuesTableView.isHiddenIfNeeded = true
                mapView.isHiddenIfNeeded = false
            }
        }
    }
    
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
        venuesTableView.isHiddenIfNeeded = false
        mapView.isHiddenIfNeeded = true
        setupBinding()
        setUpLocationManager()
    }
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        tabsCollectionView.selectItem(at: IndexPath(item: 0, section: 0),
                                      animated: true,
                                      scrollPosition: .centeredVertically)
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
    func goToLocation() {

          let camera = GMSCameraPosition.camera(withLatitude: 30 , longitude: 31 , zoom: 8)
          
          mapView.camera = camera
          
      }
    func mapView(_ mapView: GMSMapView, idleAt position: GMSCameraPosition) {
           
           let position = CLLocationCoordinate2D(latitude: 30, longitude: 31)
           
           let marker = GMSMarker(position: position)
           
           marker.map = self.mapView
       }
    
}

// MARK: - Extension For UICollectionView Delegation
extension HomeVC: UICollectionViewDelegate, UICollectionViewDataSource {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return  2
    }
    
    func collectionView(_ collectionView: UICollectionView,
                        cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(with: TabCell.self, for: indexPath)
        cell.configure(title: tabsTitles[indexPath.item])
        return cell
        
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        self.viewtype = ViewType(rawValue: indexPath.item) ?? .listView
    }
  
}

// MARK: - Extension For UICollectionView Layout
extension HomeVC: UICollectionViewDelegateFlowLayout {
    
    func collectionView(_ collectionView: UICollectionView,
                        layout collectionViewLayout: UICollectionViewLayout,
                        sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: 100, height: 36)
    }
    
    func collectionView(_ collectionView: UICollectionView,
                        layout collectionViewLayout: UICollectionViewLayout,
                        minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        return   0
    }
    
    func collectionView(_ collectionView: UICollectionView,
                        layout collectionViewLayout: UICollectionViewLayout,
                        minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 0
    }
    
}
