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
    
    //MARK: - Lifecycle
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        checkIfUserIsLoggedIn()
        signOut()
        
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
        view.addSubview(mapView)
        mapView.frame = view.frame
    }

}
