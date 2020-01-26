//
//  DisponibilityAPIService.swift
//  Findout
//
//  Created by Vithursan Sivakumaran on 09/01/2020.
//  Copyright © 2020 Ramzy Kermad. All rights reserved.
//

import Foundation
import Alamofire

class DisponibilityAPIService: DisponibilityServices {

    let localServiceAddress = "http://localhost:3000/disponibility"
    let onlineServiceAddress = "https://findout-esgi.herokuapp.com/disponibility"

    public static let `default` = DisponibilityAPIService()

    func getAll(completion: @escaping ([DisponibilityDao]) -> Void) {
        Alamofire.request("\(onlineServiceAddress)/getAll").responseJSON { (res) in
            guard let jsonCategory = res.result.value as? [String:Any] else {
                return
            }
            guard let disponibilityList = jsonCategory["disponibility"] as? [[String:Any]] else {
                return
            }
            var list : [DisponibilityDao] = []
            disponibilityList.forEach { (result) in
                guard let  id = result["_id"] as? String,
                    let date = result["date"] as? String,
                    let startTime = result["startTime"] as? String,
                    let endTime = result["endTime"] as? String,
                    let nbPlace = result["nbPlace"] as? Int,
                    let id_user = result["id_user"] as? String,
                    let id_place = result["id_place"] as? String else {
                        return
                }
                list.append(DisponibilityDao.init(id: id, date: date, startTime: startTime, endTime: endTime, place: nbPlace, userID: id_user, placeID: id_place))
            }
            completion(list)
        }
    }

    func getByIdPlaceAndDate(placeId: String, date: String, completion: @escaping ([DisponibilityDao]) -> Void) {
        Alamofire.request("\(onlineServiceAddress)/getByIdPlaceAndDate/\(placeId)/\(date)").responseJSON { (res) in
            guard let jsonCategory = res.result.value as? [String:Any] else {
                return
            }
            guard let disponibilityList = jsonCategory["disponibility"] as? [[String:Any]] else {
                return
            }
            var list : [DisponibilityDao] = []
            disponibilityList.forEach { (result) in
                guard let  id = result["_id"] as? String,
                    let date = result["date"] as? String,
                    let startTime = result["startTime"] as? String,
                    let endTime = result["endTime"] as? String,
                    let nbPlace = result["nbPlace"] as? Int,
                    let id_user = result["id_user"] as? String,
                    let id_place = result["id_place"] as? String else {
                        return
                }
                list.append(DisponibilityDao.init(id: id, date: date, startTime: startTime, endTime: endTime, place: nbPlace, userID: id_user, placeID: id_place))
            }
            completion(list)
        }
    }

    func addDisponibility(id_place: String, id_user: String, startTime: String, endTime: String, date: String, nbPlace: String, completion: @escaping (Int) -> Void) {
        let params : [String : Any] = [
            "id_place" : id_place,
            "id_user" : id_user,
            "startTime" : startTime + ":00",
            "endTime" : endTime + ":00",
            "date" : date,
            "nbPlace" : nbPlace
        ]
        Alamofire.request("\(onlineServiceAddress)/addDisponibility", method: .post, parameters: params, encoding: JSONEncoding.default).responseJSON { (res) in
            completion((res.response?.statusCode)!)
        }
    }
}
