//
//  DisponibilityDao.swift
//  Findout
//
//  Created by Ramzy Kermad on 19/12/2019.
//  Copyright © 2019 Ramzy Kermad. All rights reserved.
//

import Foundation


struct DisponibilityDao {
    
     var id_disponibility: String = ""
     var date: String = ""
     var startTime: String = ""
     var endTime: String = ""
     var nbPlace: Int = 0
     var id_user: String = ""
     var id_place: String = ""
    
    init?(jsonResponse: [String: Any]) {
        guard let dispoId = jsonResponse["id_disponibility"] as? String,
                let date = jsonResponse["date"] as? String,
                let start = jsonResponse["start_time"] as? String,
                let end = jsonResponse["end_time"] as? String,
                let placesCount = jsonResponse["nb_places"] as? String,
                let userId = jsonResponse["id_user"] as? String,
                let placeId = jsonResponse["id_place"] as? String else{
                return
        }
        
        self.id_disponibility = dispoId
        self.date = date
        self.start_time = start
        self.endTime = end
        self.nbPlace = placesCount
        self.id_user = userId
        self.id_place = placeId
    }
}
