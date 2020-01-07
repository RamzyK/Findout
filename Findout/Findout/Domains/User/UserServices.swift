//
//  UserServices.swift
//  findout
//
//  Created by Ramzy Kermad on 18/12/2019.
//  Copyright © 2019 Ramzy Kermad. All rights reserved.
//

import Foundation
import CoreLocation

protocol UserServices{
    func getAll(completion: @escaping ([UserDao]) -> Void)
    func getById(_ id: String, completion: @escaping (UserDao?) -> Void)
    func addUser(user: UserDao, password: String, completion: @escaping (UserDao) -> Void)
    func connect(email: String, password: String, completion: @escaping(UserDao) -> Void)
}
