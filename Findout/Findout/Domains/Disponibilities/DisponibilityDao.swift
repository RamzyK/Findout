//
//  DisponibilityDao.swift
//  Findout
//
//  Created by Ramzy Kermad on 19/12/2019.
//  Copyright © 2019 Ramzy Kermad. All rights reserved.
//

import Foundation


struct DisponibilityDao {
    
     var id: String = ""
     var date: String = ""
     var startTime: String = ""
     var endTime: String = ""
     var placesAvailable: Int = 0
     var userID: String = ""
     var placeID: String = ""
    
    init?(jsonResponse: [String: Any]) {
        guard let dispoId = jsonResponse["id_disponibility"] as? String,
                let date = jsonResponse["date"] as? String,
                let start = jsonResponse["start_time"] as? String,
                let end = jsonResponse["end_time"] as? String,
                let placesCount = jsonResponse["nb_places"] as? Int,
                let userId = jsonResponse["id_user"] as? String,
                let placeId = jsonResponse["id_place"] as? String else{
                return
        }
        
        self.id = dispoId
        self.date = date
        self.startTime = start
        self.endTime = end
        self.placesAvailable = placesCount
        self.userID = userId
        self.placeID = placeId
    }
}
