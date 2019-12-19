//
//  ActivityDao.swift
//  Findout
//
//  Created by Ramzy Kermad on 19/12/2019.
//  Copyright © 2019 Ramzy Kermad. All rights reserved.
//

import Foundation

struct ActivityDao {
    // Represente le type d'activité voulue
    // Elle comprend 0, 1 ou plusieurs catégories d'activités
    
    var name: String
    var activityID: String
    var categoryListID: String
    
    init?(jsonResponse: [String: Any]){
        self.name = ""
        self.activityID = ""
        self.categoryListID = ""
        guard let name = jsonResponse["name"] as? String,
                let activityId = jsonResponse["activity_id"] as? String,
                let catListId = jsonResponse["category_list_id"] as? String else{
                return
        }
    }
    
    init(activityName: String, activityId: String, catListId: String){
        self.name = activityName
        self.activityID = activityId
        self.categoryListID = catListId
    }
}
