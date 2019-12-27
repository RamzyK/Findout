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
    var id: String
    var categoryListID: String
    
    init?(jsonResponse: [String: Any]){
        self.name = ""
        self.id = ""
        self.categoryListID = ""
        guard let name = jsonResponse["name"] as? String,
                let activityId = jsonResponse["activity_id"] as? String,
                let catListId = jsonResponse["category_list_id"] as? String else{
                return
        }
        self.name = name
        self.id = activityId
        self.categoryListID = catListId
    }
    
    init(activityName: String, activityId: String, catListId: String){
        self.name = activityName
        self.id = activityId
        self.categoryListID = catListId
    }
}
