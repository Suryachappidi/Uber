//
//  HomeController.swift
//  Uber
//
//  Created by Surya Chappidi on 10/09/20.
//  Copyright © 2020 Surya Chappidi. All rights reserved.
//

import UIKit
import Firebase
import MapKit

class HomeController: UIViewController {
    
    //MARK: - Properties
    private let mapView = MKMapView()
    private let locationManager = CLLocationManager()
    
    //MARK: - Lifecycle
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        checkIfUserIsLoggedIn()
        enableLocationServices()
//        signOut()
        
    }
    
    //MARK: - API
    
    func checkIfUserIsLoggedIn(){
        if Auth.auth().currentUser?.uid == nil {
            DispatchQueue.main.async {
                let nav = UINavigationController(rootViewController: LoginController())
                nav.modalPresentationStyle = .fullScreen
                self.present(nav, animated: true, completion: nil)
            }
        }
        else {
            configureUI()
        }
    }
    
    func signOut() {
        do {
            try Auth.auth().signOut()
        }
        catch let error {
            print("DEBUG: Error Signing Out \(error)")
        }
    }
    
    //MARK: - Helper
    
    func configureUI(){
       configureMapView()
    }
    
    func configureMapView(){
        view.addSubview(mapView)
        mapView.frame = view.frame
        
        mapView.showsUserLocation = true
        mapView.userTrackingMode = .follow
    }

}

    //MARK: - LocationServices

extension HomeController: CLLocationManagerDelegate{
    func enableLocationServices(){
        locationManager.delegate = self
        
        switch CLLocationManager.authorizationStatus(){
        case .notDetermined:
            locationManager.requestWhenInUseAuthorization()
            print("Debug: hello")
        case .restricted,.denied:
            break
        case .authorizedAlways:
            print("DEBUG: Auth Always")
            locationManager.startUpdatingLocation()
            locationManager.desiredAccuracy = kCLLocationAccuracyBest
        case .authorizedWhenInUse:
            print("DEBUG: Auth in Use")
            locationManager.requestAlwaysAuthorization()
        @unknown default:
            break
        }
    }
    
    func locationManager(_ manager: CLLocationManager, didChangeAuthorization status: CLAuthorizationStatus) {
        
        if status == .authorizedWhenInUse{
            locationManager.requestAlwaysAuthorization()
        }
    }
}
