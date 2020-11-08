//
//  LocationHandler.swift
//  Uber
//
//  Created by Surya Chappidi on 08/11/20.
//  Copyright © 2020 Surya Chappidi. All rights reserved.
//

import CoreLocation

class LocationHandler: NSObject, CLLocationManagerDelegate {
    
    static let shared = LocationHandler()
    
    var locationManager: CLLocationManager!
    var location: CLLocation!
    
    override init() {
        super.init()
        
        locationManager = CLLocationManager()
        locationManager.delegate = self
    }
    
    func locationManager(_ manager: CLLocationManager, didChangeAuthorization status: CLAuthorizationStatus) {
        
        if status == .authorizedWhenInUse{
            locationManager.requestAlwaysAuthorization()
        }
    }
    
}
