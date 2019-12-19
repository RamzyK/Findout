//
//  PlaceDao.swift
//  findout
//
//  Created by Ramzy Kermad on 18/12/2019.
//  Copyright © 2019 Ramzy Kermad. All rights reserved.
//

import Foundation

struct PlaceDao {
    
     var id_place: String = ""
     var name: String = ""
     var coordinate: [String: Float] = [:]
     var nb_seat: Int = 0
     var nb_seat_free: Int = 0
     var address: String = ""
     var disponibilityStartTime: DisponibilityDao?
    var disponibilityEndTime: DisponibilityDao?
     var id_notation_list: String = ""
     var id_user: String = ""
     
    init?(jsonResponse: [String: Any]){
        guard let idPlace = jsonResponse["id_place"] as? String,
                let placeName = jsonResponse["name"] as? String,
                let coordinates = jsonResponse["coordinate"] as? [String: Float],
                let nbSeat = jsonResponse["nb_seat"] as? Int,
                let nbSeatFree = jsonResponse["nb_seat_free"] as? Int,
                let placeAdress = jsonResponse["adress"] as? String,
                let idNotationList = jsonResponse["id_nnotation_list"] as? String,
                let idUser = jsonResponse["id_user"] as? String else{
                return
        }
        
        self.id_place = idPlace
        self.name = placeName
        self.coordinate = coordinates
        self.nb_seat = nbSeat
        self.nb_seat_free = nbSeatFree
        self.address = placeAdress
        self.id_notation_list = idNotationList
        self.id_user = idUser
        
    }
}
