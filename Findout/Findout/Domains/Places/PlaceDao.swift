//
//  PlaceDao.swift
//  findout
//
//  Created by Ramzy Kermad on 18/12/2019.
//  Copyright © 2019 Ramzy Kermad. All rights reserved.
//

import Foundation
import CoreLocation

struct PlaceDao {

     var id: String = ""
     var name: String = ""
     var coordinate: [String: Double] = [:]
     var location: CLLocation
     var totalSeat: Int = 0
     var availableSeat: Int = 0
     var address: [String] = [] // 1. Num de rue + Rue - 2.Code postal + nom du département - 3. Pays
     var disponibilityStartTime: String?
     var disponibilityEndTime: String?
     var id_notation_list: String = ""
     var id_user: String = ""

    init?(jsonResponse: [String: Any]){
        location = CLLocation()
        guard let idPlace = jsonResponse["id_place"] as? String,
                let placeName = jsonResponse["name"] as? String,
                let coordinates = jsonResponse["coordinate"] as? [String: Double],
                let nbSeat = jsonResponse["nb_seat"] as? Int,
                let nbSeatFree = jsonResponse["nb_seat_free"] as? Int,
                let placeAdress = jsonResponse["address"] as? [String],
                let dispoStart = jsonResponse["disponibilityStartTime"] as? String,
                let dispoEnd = jsonResponse["disponibilityEndTime"] as? String,
                let idNotationList = jsonResponse["id_nnotation_list"] as? String,
                let idUser = jsonResponse["id_user"] as? String else{
                return
        }

        self.id = idPlace
        self.name = placeName
        self.coordinate = coordinates
        self.location = CLLocation(latitude: self.coordinate["lat"]!, longitude: self.coordinate["long"]!)
        //self.location = CLLocation(latitude: 48.849329, longitude: 2.3875453)
        self.totalSeat = nbSeat
        self.disponibilityStartTime = dispoStart
        self.disponibilityEndTime = dispoEnd
        self.availableSeat = nbSeatFree
        self.address = placeAdress
        self.id_notation_list = idNotationList
        self.id_user = idUser

    }

    init(id_place: String, place_Name: String, coordinates: [String: Double], location: CLLocation, nb_seat: Int, nb_seat_free: Int, address: [String], disponibility_start_time: String?, disponibility_end_time: String?, id_notation_list: String, id_user: String) {
        self.id = id_place
        self.name = place_Name
        self.coordinate = coordinates
        self.totalSeat = nb_seat
        self.availableSeat = nb_seat_free
        self.address = address
        self.location = location
        if(disponibility_end_time != nil) {
            self.disponibilityStartTime = disponibility_start_time
        }
        if(disponibility_end_time != nil) {
            self.disponibilityEndTime = disponibility_end_time
        }
        self.id_notation_list = id_notation_list
        self.id_user = id_user
    }
}
