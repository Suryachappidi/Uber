//
//  Service.swift
//  Uber
//
//  Created by Surya Chappidi on 05/10/20.
//  Copyright © 2020 Surya Chappidi. All rights reserved.
//

import Firebase

let DB_REF = Database.database().reference()
let REF_USERS = DB_REF.child("users")

struct Service {
    static let shared = Service()
    
    let currentUid = Auth.auth().currentUser?.uid
    
    func fectchUserData(completion: @escaping(User) -> Void){
        REF_USERS.child(currentUid!).observeSingleEvent(of: .value) { (snapshot) in
            guard let dictonary = snapshot.value as? [String: Any] else {return}
            let user = User(dictionary: dictonary)
            
            completion(user)
        }
    }
}
