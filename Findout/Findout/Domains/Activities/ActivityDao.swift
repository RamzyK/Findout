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
    var categories: [CategoryDao]
    var isExpanded: Bool
    
    init?(jsonResponse: [String: Any]){
        guard let name = jsonResponse["name"] as? String,
            let activityId = jsonResponse["_id"] as? String,
            let jsonCategory = jsonResponse["categories"] as? [[String:Any]] else { return nil }
            let categories = jsonCategory.compactMap({ (elem) -> CategoryDao? in
                return CategoryDao(jsonReponse: elem)
        })

        self.name = name
        self.id = activityId
        self.categories = categories
        self.isExpanded = false
    }
    
    init(activityName: String, activityId: String, categories: [CategoryDao]){
        self.name = activityName
        self.id = activityId
        self.categories = categories
        self.isExpanded = false
    }
}
