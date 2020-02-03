//
//  ActivityMockServices.swift
//  Findout
//
//  Created by Ramzy Kermad on 24/12/2019.
//  Copyright © 2019 Ramzy Kermad. All rights reserved.
//

import Foundation

class ActivityMockServices: ActivityServices{
    
    static let categories: [CategoryDao] = [
        CategoryDao(name: "toz", imageUrl: "https://upload.wikimedia.org/wikipedia/commons/1/16/Armlock_juji-gatame_armbar.jpg", idCat: "1", idActivity: "1")
    ]
    
    private var activities: [ActivityDao] = [
        ActivityDao(activityName: "Sortie", activityId: "1111", categories: categories),
        ActivityDao(activityName: "Bar", activityId: "1111", categories: categories),
        ActivityDao(activityName: "Restaurant", activityId: "1111", categories: categories),
        ActivityDao(activityName: "Sport", activityId: "1111", categories: categories)
    ]
    
    func getAll(completion: @escaping ([ActivityDao]) -> Void) {
        completion(activities)
    }
    
    
    func create(activity: ActivityDao) {
        self.activities.append(activity)
    }
    
    
}
