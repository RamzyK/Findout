//
//  UserAPIService.swift
//  findout
//
//  Created by Ramzy Kermad on 18/12/2019.
//  Copyright © 2019 Ramzy Kermad. All rights reserved.
//

import Foundation
import Alamofire

class UserAPIService : UserServices{
    
    let localServiceAddress = "http://localhost:3000/users"
    let onlineServiceAddress = "https://findout-esgi.herokuapp.com/users"
    
    public static let `default` = UserAPIService()
    
    func getAll(completion: @escaping ([UserDao]) -> Void) {
        
    }
    func getById(_ id: String, completion: @escaping (UserDao?) -> Void) {
        
    }
    
    func addUser(user : UserDao, password : String, completion: @escaping (UserDao?, Int) -> Void) {
        let params = [
            "firstname": user.firstname,
            "lastname": user.lastname,
            "password": password,
            "birthDate": user.birthDate,
            "email": user.email,
            "telephone": user.telephone
            ] as [String : Any]
        
        Alamofire.request("\(onlineServiceAddress)/addUser", method: .post, parameters: params, encoding: JSONEncoding.default).responseJSON { (res) in
            var user: UserDao?
            guard let statusCode = res.response?.statusCode else {
                completion(user, 500)
                return
            }
            if statusCode == 200 {
                guard let json = res.result.value as? [String:Any],
                let userData = json["user"] as? [String:Any] else {
                    return
                }
                user = UserDao.init(jsonResponse: userData)
            }
            completion(user, statusCode)
        }
    }
    
    func connect(email: String, password: String, completion: @escaping(UserDao?, Int) -> Void) {
        let params : [String : String] = [
            "email" : email,
            "password" : password
        ]
        Alamofire.request("\(onlineServiceAddress)/connect", method: .post, parameters: params, encoding: JSONEncoding.default).responseJSON { (res) in
            var user: UserDao?
            guard let statusCode = res.response?.statusCode else {
                completion(user, 400)
                return
            }
            if statusCode == 200 {
                guard let json = res.result.value as? [String:Any],
                    let userData = json["user"] as? [String:Any] else {
                    return
                }
                user = UserDao.init(jsonResponse: userData)
            }
            completion(user, statusCode)
        }
    }
}
