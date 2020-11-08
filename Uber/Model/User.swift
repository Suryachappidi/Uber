//
//  User.swift
//  Uber
//
//  Created by Surya Chappidi on 08/11/20.
//  Copyright © 2020 Surya Chappidi. All rights reserved.
//

struct User{
    let fullname: String
    let email: String
    let accountType: Int
    
    init(dictionary: [String: Any]) {
        self.fullname = dictionary["fullname"] as? String ?? ""
        self.email = dictionary["email"] as? String ?? ""
        self.accountType = dictionary["accountType"] as? Int ?? 0
    }
}
