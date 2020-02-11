//
//  PlaceAPIService.swift
//  findout
//
//  Created by Ramzy Kermad on 18/12/2019.
//  Copyright © 2019 Ramzy Kermad. All rights reserved.
//

import Foundation
import Alamofire
import CoreLocation

class PlaceAPIService: PlaceServices{


    let localServiceAddress = "http://localhost:3000/place"
    let onlineServiceAddress = "https://findout-esgi.herokuapp.com/place"

    public static let `default` = PlaceAPIService()

    func getAll(completion: @escaping ([PlaceDao]) -> Void) {

    }

    func getByIdCategory(id: String, completion: @escaping ([PlaceDao]) -> Void) {
        Alamofire.request("\(onlineServiceAddress)/getByIdCategory/\(id)").responseJSON { (res) in
            guard let jsonCategory = res.result.value as? [String:Any],
                let categoryList = jsonCategory["place"] as? [[String: Any]] else { return }
            var list : [PlaceDao] = []
                
            categoryList.forEach { (result) in

                guard let  id = result["_id"] as? String,
                    let idUser = result["id_user"] as? String,
                    let _ = result["id_category"] as? String,
                    let coordinate = result["coordinate"] as? [String : Double],
                    let name = result["name"] as? String,
                    let nbSeat = result["nb_seat"] as? Int,
                    let nbSeatFree = result["nb_seat_free"] as? Int,
                    let address = result["arrAddress"] as? [String],
                    let lon = coordinate["lon"],
                    let lat = coordinate["lat"],
                    let dispoStart = result["disponibilityStartTime"] as? String,
                    let dispoEnd = result["disponibilityEndTime"] as? String,
                    let image = result["url_image"] as? String else { return }

                    let placeDao = PlaceDao.init(id_place: id, place_Name: name, coordinates: coordinate, location : CLLocation(latitude: lat, longitude: lon), nb_seat: nbSeat, nb_seat_free: nbSeatFree, address: address, disponibility_start_time: dispoStart, disponibility_end_time: dispoEnd, id_notation_list: "", id_user: idUser, place_image: image)
                list.append(placeDao)
            }

            completion(list)
        }
    }

    func getById(id: String, completion: @escaping (PlaceDao) -> Void) {
        Alamofire.request("\(onlineServiceAddress)/getById/\(id)").responseJSON { (res) in
            guard let jsonCategory = res.result.value as? [String:Any] else {
                return
            }
            guard let categoryList = jsonCategory["place"] as? [[String: Any]] else {
                return
            }
            var list : [PlaceDao] = []
            categoryList.forEach { (result) in
                
                guard let  id = result["_id"] as? String,
                    let idUser = result["id_user"] as? String,
                    let _ = result["id_category"] as? String,
                    let coordinate = result["coordinate"] as? [String : Double],
                    let lon = coordinate["lon"],
                    let lat = coordinate["lat"],
                    let name = result["name"] as? String,
                    let nbSeat = result["nb_seat"] as? Int,
                    let nbSeatFree = result["nb_seat_free"] as? Int,
                    let address = result["arrAddress"] as? [String],
                    let dispoStart = result["disponibilityStartTime"] as? String,
                    let dispoEnd = result["disponibilityEndTime"] as? String,
                    let image = result["url_image"] as? String
                else {
                        return
                }
                
                list.append(PlaceDao.init(id_place: id, place_Name: name, coordinates: coordinate, location : CLLocation(latitude: lat, longitude: lon), nb_seat: nbSeat, nb_seat_free: nbSeatFree, address: address, disponibility_start_time: dispoStart, disponibility_end_time: dispoEnd, id_notation_list: "", id_user: idUser, place_image: image))
            }
            
            completion(list[0])
        }
    }

    func create(params: [String:Any], image: UIImage, completion: @escaping (SessionManager.MultipartFormDataEncodingResult) -> Void) {
        Alamofire.upload(multipartFormData: { multipartFormData in
            if let imageData = image.jpegData(compressionQuality: 1) {
                guard var imageName = params["name"] as? String else { return }
                imageName += ".png"
                multipartFormData.append(imageData, withName: "image", fileName: imageName, mimeType: "image/png")
            }
            for (key, value) in params {
                if let val = value as? String {
                    multipartFormData.append((val.data(using: .utf8))!, withName: key)
                } else if let valTab = value as? [String:String] {
                    guard let longitude = valTab["lon"],
                        let latitude = valTab["lat"] else { return }
                    multipartFormData.append(longitude.data(using: .utf8)!, withName: "coordinate[\"lon\"]")
                    multipartFormData.append(latitude.data(using: .utf8)!, withName: "coordinate[\"lat\"]")
                }
            }
        },
            usingThreshold:UInt64.init(),
            to: "\(onlineServiceAddress)/addPlace",
            method: .post,
            headers: ["Authorization": "auth_token"],
            encodingCompletion: { encodingResult in
                print(encodingResult)
                completion(encodingResult)
            }
        )
    }


}
