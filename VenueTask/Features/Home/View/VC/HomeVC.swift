//
//  HomeVC.swift
//  VenuesTask
//
//  Created by Ibtikar on 13/12/2022.
//

import UIKit
import CoreLocation
import GoogleMaps
import SideMenu

enum ViewType: Int {
    case listView = 0
    case googleMaps
}

class HomeVC: BaseVC {
    // MARK: - Outlets
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
    private var infoWindow = CustomMapMarkerWindow(frame: .zero)
    var menu: SideMenuNavigationController?
    
    var viewtype: ViewType = .listView {
        didSet {
            switch viewtype {
            case .listView:
                infoWindow.removeFromSuperview()
                venuesTableView.isHiddenIfNeeded = false
                mapView.isHiddenIfNeeded = true
            case .googleMaps:
                venuesTableView.isHiddenIfNeeded = true
                mapView.isHiddenIfNeeded = false
                self.addMarkers()
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
        infoWindow.removeFromSuperview()
        setupInitialUI()
        setupBinding()
        setUpLocationManager()
    }
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.navigationController?.navigationBar.isHidden = true
       
    //    viewtype = .listView
    }
    
    @IBAction func openSideMenu(_ sender: Any) {
         menu = SceneContainer.openSideMenu(menuDelegate: self)
        menu?.sideMenuDelegate = self
        if let menu {
            self.present(menu, animated: true)
        }
       
    }
    
}
// MARK: - Initial
extension HomeVC {
    private func setupInitialUI() {
        venuesTableView.isHiddenIfNeeded = false
        mapView.isHiddenIfNeeded = true
        tabsCollectionView.selectItem(at: IndexPath(item: 0, section: 0),
                                      animated: true,
                                      scrollPosition: .centeredVertically)
        setUpTableView()
    }
    private func setUpTableView() {
        venuesTableView.dataSource = self
        venuesTableView.delegate   = self
        venuesTableView.register(cellType: VenueCell.self)
    }
    func setupBinding() {
        viewModel.onSuccessFetching = { [weak self] in
            guard let self else { return }
            self.venuesTableView.reloadData()
           
        }
    }
    private func setUpLocationManager() {
         mapView.delegate = self
        cLocationManager.delegate = self
        cLocationManager.desiredAccuracy = kCLLocationAccuracyBest
        locationAuthStatus()
        
    }
    func locationAuthStatus() {
        switch cLocationManager.authorizationStatus {
        case .notDetermined:
            cLocationManager.requestWhenInUseAuthorization()
        case .restricted, .denied:
            self.showMessage(message: "Location Not Enabled", type: .error)
        case .authorizedAlways, .authorizedWhenInUse:
            cLocationManager.startUpdatingLocation()
        @unknown default:
            break
        }
    }
}
// MARK: - Location
extension HomeVC: CLLocationManagerDelegate {
    
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        guard let location: CLLocation = locations.last else {return}
        
        let latitude = location.coordinate.latitude
        let longitude = location.coordinate.longitude
        let userLocation = UserLocation(latitude: latitude, longitude: longitude)
        PersistenceManager.save(value: userLocation)
        cLocationManager.stopUpdatingLocation()
        viewModel.viewWillAppear()
    }
    
    func locationManager(_ manager: CLLocationManager, didChangeAuthorization status: CLAuthorizationStatus) {
        locationAuthStatus()
    }
    func addMarkers() {
        for index in 0..<viewModel.getVenuesCount() {
            
            let venue = viewModel.getVenue(item: index)
            let lat = venue?.location?.lat ?? 0
            let long = venue?.location?.lng ?? 0
            
            let camera = GMSCameraPosition.camera(withLatitude: lat, longitude: long, zoom: 17)
            mapView.camera = camera
            let marker: GMSMarker = GMSMarker()
            marker.userData = venue
            marker.appearAnimation = .pop
            marker.position = CLLocationCoordinate2DMake(lat, long)
            DispatchQueue.main.async {[weak self] in
                // Setting marker on mapview in main thread.
                marker.map = self?.mapView // Setting marker on Mapview
            }
        }
        
    }
}

extension HomeVC: GMSMapViewDelegate {
    
    // if you click on marker itself
    func mapView(_ mapView: GMSMapView, didTap marker: GMSMarker) -> Bool {
        let venue = marker.userData as? Venue
        infoWindow.removeFromSuperview()
        let frame = CGRect(x: 0, y: 0, width: 200, height: 140)
        infoWindow = CustomMapMarkerWindow(frame: frame)
        infoWindow.setup(venue: venue)
        infoWindow.alpha = 0.8
        infoWindow.center = mapView.projection.point(for: marker.position)
        infoWindow.center.y += 50
        self.view.addSubview(infoWindow)
       return false
    }
    
    // if you click on place outside marker
    func mapView(_ mapView: GMSMapView, didTapAt coordinate: CLLocationCoordinate2D) {
        infoWindow.removeFromSuperview()
    }
}

extension HomeVC: SideMenuNavigationControllerDelegate {
    
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

extension HomeVC: SidemenuClassdelegate {
    func itemClicked(type: MoreTypes) {
        menu?.dismiss(animated: true)
        menu = nil
        switch type {
        case .home:
          print("home is current")
        case .myProfile:
            myProfileItemSelected()
        case .termsAndConditions:
           termsItemSelected()
        case .logout:
            AppManager.shared.logout()
        }
        
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
  
}
