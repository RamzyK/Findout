//
//  ActivityAPIService.swift
//  Findout
//
//  Created by Vithursan Sivakumaran on 06/01/2020.
//  Copyright © 2020 Ramzy Kermad. All rights reserved.
//

import Foundation
import Alamofire

class ActivityAPIService : ActivityServices{

    let localServiceAddress = "http://localhost:3000/activity"
    let onlineServiceAddress = "https://findout-esgi.herokuapp.com/activity"

    public static let `default` = ActivityAPIService()

    func getAll(completion: @escaping ([ActivityDao]) -> Void) {
        Alamofire.request("\(localServiceAddress)/getAll").responseJSON { (res) in
            guard let jsonCategory = res.result.value as? [String:Any],
                let categoryList = jsonCategory["activity"] as? [[String:Any]] else { return }
                let list = categoryList.compactMap { (elem) -> ActivityDao? in
                return ActivityDao(jsonResponse: elem)
            }
            completion(list)
        }
    }

    func create(activity: ActivityDao) {

    }
}
