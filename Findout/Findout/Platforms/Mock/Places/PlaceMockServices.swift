//
//  PlaceMockServices.swift
//  Findout
//
//  Created by Ramzy Kermad on 25/12/2019.
//  Copyright © 2019 Ramzy Kermad. All rights reserved.
//

import Foundation

class PlacesMockServices: PlaceServices {
    private var allPlaces: [PlaceDao] = [
        PlaceDao(id_place: "1111", placeName: "L'ESGI",
                 coordinates: ["lat": 48.849329, "long": 2.3875453],
                 nb_seat: 10, nb_seat_free: 10,
                 address: "123 Avenue de ta grand mère",
                 disponibilityStartTime: "DisponibilityDao", disponibilityEndTime: "",
                 id_notation_list: "1919", id_user: "1A1A"),
        
        PlaceDao(id_place: "2222", placeName: "Boulbi",
                coordinates: ["lat": 48.9460785, "long": 2.3168825],
                nb_seat: 10, nb_seat_free: 10,
                address: "123 Avenue de ton grand père",
                disponibilityStartTime: "XXXX/XX/XX", disponibilityEndTime: "XXXX/XX/XX",
                id_notation_list: "2929", id_user: "2Z2Z"),
        
        PlaceDao(id_place: "3333", placeName: "Gringny la grande borne",
                 coordinates: ["lat": 48.8580021, "long": 2.345054],
                nb_seat: 10, nb_seat_free: 10,
                address: "123 Avenue de ton daron",
                disponibilityStartTime: "DisponibilityDao", disponibilityEndTime: "",
                id_notation_list: "3939", id_user: "3E3E"),
        
    ]
    func getAll(completion: @escaping ([PlaceDao]) -> Void) {
        completion(allPlaces)
    }
    
    func getById(_ id: String, completion: @escaping (PlaceDao?) -> Void) {
        completion(self.allPlaces.first(where: { (r) -> Bool in
            return r.id == id
        }))
    }
    
    func create(place: PlaceDao) {
        
    }
    
    
}
