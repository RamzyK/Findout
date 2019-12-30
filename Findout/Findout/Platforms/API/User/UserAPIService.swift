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
    
    func addUser(user : UserDao, password : String, completion: @escaping (UserDao) -> Void) {
        let params = [
            "firstname": user.firstname,
            "lastname": user.lastname,
            "password": password,
            "birthDate": user.birthDate!,
            "email": user.email!,
            "telephone": user.telephone
            ] as [String : Any]
        
        Alamofire.request("\(onlineServiceAddress)/addUser", method: .post, parameters: params, encoding: JSONEncoding.default).responseString { (res) in
            print(res)
            //completion(res.response?.statusCode == 201)
        }
    }
    
    func connect(email: String, password: String, completion: @escaping(UserDao) -> Void) {
        let params : [String : String] = [
            "email" : email,
            "password" : password
        ]
        print(params)
        Alamofire.request("\(localServiceAddress)/connect/\(email)/\(password)").responseJSON { (res) in
            guard let jsonUser = res.result.value as? [String:Any] else {
                return
            }
            guard let userData = jsonUser["user"] as? [[String:String]] else {
                return
            }
            var user : UserDao?
            if(userData.count > 0) {
                guard let userJson = userData[0] as? [String:String] else {
                        return
                }
                user = UserDao.init(jsonResponse: userJson)
            } else {
                user = UserDao(id: "", firstname: "", lastname: "", birthDate: "", email: "", tel: "")
            }
            completion(user!)
        }
    }
}
