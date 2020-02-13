//
//  PlaceMockServices.swift
//  Findout
//
//  Created by Ramzy Kermad on 25/12/2019.
//  Copyright © 2019 Ramzy Kermad. All rights reserved.
//

import Foundation
import UIKit
import Alamofire
import CoreLocation

class PlacesMockServices: PlaceServices {


    private var allPlaces: [PlaceDao] = [
        PlaceDao(id_place: "1111", place_Name: "L'ESGI",
                 coordinates: ["lat": 48.849329, "long": 2.3875453],
                 location: CLLocation(latitude: 48.849329, longitude: 2.3875453),
                 nb_seat: 10, nb_seat_free: 10,
                 address: ["123 Avenue du boulevard", "75002 Paris", "France"],
                 disponibility_start_time: "DisponibilityDao", disponibility_end_time: "",
                 id_notation_list: "1919", id_user: "1A1A", place_image: ""),
        
        PlaceDao(id_place: "2222", place_Name: "Boulbi",
                 coordinates: ["lat": 48.9460785, "long": 2.3168825],
                 location: CLLocation(latitude: 48.9460785, longitude: 2.3168825),
                 nb_seat: 10, nb_seat_free: 10,
                 address: ["123 Avenue de la rue", "75003 Paris", "France"],
                 disponibility_start_time: "XXXX/XX/XX", disponibility_end_time: "XXXX/XX/XX",
                id_notation_list: "2929", id_user: "2Z2Z", place_image: ""),
        
        PlaceDao(id_place: "3333", place_Name: "Gringny la grande borne",
                 coordinates: ["lat": 48.8580021, "long": 2.345054],
                 location: CLLocation(latitude: 48.8580021, longitude: 2.345054),
                 nb_seat: 10, nb_seat_free: 10,
                 address: ["123 Avenue de l'avenue", "75004 Paris", "France"],
                 disponibility_start_time: "DisponibilityDao", disponibility_end_time: "",
                id_notation_list: "3939", id_user: "3E3E",place_image: ""),
        
    ]
    func getAll(completion: @escaping ([PlaceDao]) -> Void) {
        completion(allPlaces)
    }
    
    func getByIdCategory(id: String, completion: @escaping ([PlaceDao]) -> Void) {
//        completion(self.allPlaces.first(where: { (r) -> Bool in
//            return r.id == id
//        }))
    }
    
    func create(params: [String:Any], image: UIImage, completion: @escaping (SessionManager.MultipartFormDataEncodingResult) -> Void) {
        
    }
    
    func getById(id: String, completion: @escaping (PlaceDao) -> Void) {
        //
    }

    
}
