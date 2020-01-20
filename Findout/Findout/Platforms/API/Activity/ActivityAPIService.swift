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
        Alamofire.request("\(onlineServiceAddress)/getAll").responseJSON { (res) in
            guard let jsonCategory = res.result.value as? [String:Any] else {
                return
            }
            guard let categoryList = jsonCategory["activity"] as? [[String:String]] else {
                return
            }
            print(categoryList)
            var list : [ActivityDao] = []
            categoryList.forEach { (result) in
                guard let  id = result["_id"],
                    let name = result["name"] else {
                        return
                }
                
                list.append(ActivityDao.init(activityName: name.capitalized, activityId: id))
            }
            
            completion(list)
        }
    }
    
    func create(activity: ActivityDao) {
        
    }
}
