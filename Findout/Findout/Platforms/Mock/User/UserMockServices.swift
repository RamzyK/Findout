//
//  UserMockServices.swift
//  Findout
//
//  Created by Ramzy Kermad on 23/12/2019.
//  Copyright © 2019 Ramzy Kermad. All rights reserved.
//

import Foundation

class UserMockServices: UserServices{
    
    private let users: [UserDao] = [
        UserDao(id: "1", firstname: "Ramzy", lastname: "Kermad", birthDate: "20/02/1998", email: "kelbay@gmail.com", tel:   "-"),
        UserDao(id: "2", firstname: "Nass", lastname: "La Menace", birthDate: "21/02/1998", email: "cbengben@gmail.com", tel:   "-"),
        UserDao(id: "3", firstname: "THE MAN", lastname: "NOT HOT", birthDate: "22/02/1998", email: "bouillaveurdu93@gmail.com", tel:   "-"),
       ]
       
       func getAll(completion: @escaping ([UserDao]) -> Void) {
           completion(self.users)
       }
       
       func getById(_ id: String, completion: @escaping (UserDao?) -> Void) {
           completion(self.users.first(where: { (r) -> Bool in
               return r.userID == id
           }))
       }
       
    func create(name: String, lastname: String, birthdate: String, email: String, number: String, completion: @escaping (UserDao) -> Void) {
        
           completion(UserDao(id: "123", firstname: name, lastname: lastname, birthDate: birthdate, email: email, tel: number))
       }
}
