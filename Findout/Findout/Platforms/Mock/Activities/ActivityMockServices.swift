//
//  ActivityMockServices.swift
//  Findout
//
//  Created by Ramzy Kermad on 24/12/2019.
//  Copyright © 2019 Ramzy Kermad. All rights reserved.
//

import Foundation

class ActivityMockServices: ActivityServices{
    
    private var categories: [ActivityDao] = [
        ActivityDao(activityName: "Sortie", activityId: "1111", catListId: ""),
        ActivityDao(activityName: "Bar", activityId: "1111", catListId: ""),
        ActivityDao(activityName: "Restaurant", activityId: "1111", catListId: ""),
        ActivityDao(activityName: "Sport", activityId: "1111", catListId: ""),
    ]
    
    func getAll(completion: @escaping ([ActivityDao]) -> Void) {
        completion(categories)
    }
    
    
    func create(cat: ActivityDao) {
        self.categories.append(cat)
    }
    
    
}
