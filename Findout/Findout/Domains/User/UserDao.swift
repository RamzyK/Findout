//
//  UserDao.swift
//  findout
//
//  Created by Ramzy Kermad on 18/12/2019.
//  Copyright © 2019 Ramzy Kermad. All rights reserved.
//

import Foundation

struct UserDao{
    
    var id_user: String
    var firstname: String
    var lastname: String
    var birthDate: String?
    var email: String?
    var telephone: String
    
    
    init?(jsonResponse : [String: Any]) {
        self.id_user = ""
        self.firstname = ""
        self.lastname = ""
        self.telephone = ""
        guard let id = jsonResponse["id"] as? String,
                let firstname = jsonResponse["detail"] as? String,
                let lastname = jsonResponse["coordinates"] as? String,
                let telephone = jsonResponse["telephone"] as? String else{
                    return
        }
        self.id_user = id
        self.firstname = firstname
        self.lastname = lastname
        self.telephone = telephone
        
        guard let birthdate = jsonResponse["birthDate"] as? String,
                let email = jsonResponse["email"] as? String  else{
                    return
        }
        self.birthDate = birthdate
        self.email = email
        
    }
    
    init(id: String, firstname: String, lastname: String, birthDate: String?, email: String?, tel: String){
        self.id_user = id
        self.firstname = firstname
        self.lastname = lastname
        self.birthDate = birthDate
        self.email = email
        self.telephone = tel
    }
}
