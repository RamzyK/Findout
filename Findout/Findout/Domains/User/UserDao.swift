//
//  UserDao.swift
//  findout
//
//  Created by Ramzy Kermad on 18/12/2019.
//  Copyright © 2019 Ramzy Kermad. All rights reserved.
//

import Foundation

struct UserDao{
    
    var userID: String
    var firstname: String
    var lastname: String
    var birthDate: String?
    var email: String?
    var telephone: String
    
    
    init?(jsonResponse : [String: Any]) {
        self.userID = ""
        self.firstname = ""
        self.lastname = ""
        self.telephone = ""
        guard let id = jsonResponse["_id"] as? String,
                let firstname = jsonResponse["firstname"] as? String,
                let lastname = jsonResponse["lastname"] as? String,
                let telephone = jsonResponse["telephone"] as? String else{
                    return
        }
        self.userID = id
        self.firstname = firstname
        self.lastname = lastname
        self.telephone = telephone
        
        guard let birthdate = jsonResponse["birthDate"] as? String,
                let email = jsonResponse["email"] as? String  else {
                    return
        }
        self.birthDate = birthdate
        self.email = email
        
    }
    
    init(id: String, firstname: String, lastname: String, birthDate: String?, email: String?, tel: String){
        self.userID = id
        self.firstname = firstname
        self.lastname = lastname
        self.birthDate = birthDate
        self.email = email
        self.telephone = tel
    }
}
