//
//  Service.swift
//  Uber
//
//  Created by Surya Chappidi on 05/10/20.
//  Copyright © 2020 Surya Chappidi. All rights reserved.
//

import Firebase
import CoreLocation
import GeoFire

let DB_REF = Database.database().reference()
let REF_USERS = DB_REF.child("users")
let REF_DRIVER_LOCATIONS = DB_REF.child("driver-locations")

struct Service {
    static let shared = Service()
    
    
    func fectchUserData(uid: String,completion: @escaping(User) -> Void){
        REF_USERS.child(uid).observeSingleEvent(of: .value) { (snapshot) in
            guard let dictonary = snapshot.value as? [String: Any] else {return}
            let uid = snapshot.key
            let user = User(uid: uid,dictionary: dictonary)
            completion(user)
        }
    }
    
    func fetchDrivers(location: CLLocation, completion: @escaping(User) -> Void) {
        let geofire = GeoFire(firebaseRef: REF_DRIVER_LOCATIONS)
        
        REF_DRIVER_LOCATIONS.observe(.value) { (snapshot) in
            geofire.query(at: location, withRadius: 50).observe(.keyEntered,with: { (uid, location) in
                self.fectchUserData(uid: uid, completion: { (user) in
                    var driver = user
                    driver.location = location
                    completion(driver)
                })
            })
        }
    }
    
    
}
