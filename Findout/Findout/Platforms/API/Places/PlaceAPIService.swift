//
//  PlaceAPIService.swift
//  findout
//
//  Created by Ramzy Kermad on 18/12/2019.
//  Copyright © 2019 Ramzy Kermad. All rights reserved.
//

import Foundation
import Alamofire

class PlaceAPIService: PlaceServices{
    
    let localServiceAddress = "http://localhost:3000"
    let onlineServiceAddress = "https://findout-esgi.herokuapp.com"
    
    public static let `default` = PlaceAPIService()
    
    func getAll(completion: @escaping ([PlaceDao]) -> Void) {
        
    }
    
    func getById(_ id: String, completion: @escaping (PlaceDao?) -> Void) {
        
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
                    //print(val.data(using: .utf8)!)
                    multipartFormData.append((val.data(using: .utf8))!, withName: key)
                } else if let valTab = value as? [String:String] {
                    //print("heouepon")
                    //print(valTab)
                    //let data = try? JSONEncoder().encode(valTab)
                    //let jsonString = String(data: data, encoding: .utf8)!
                    //print(data!)
                    guard let longitude = valTab["lon"] as? String,
                        let latitude = valTab["lat"] as? String else {
                            return
                    }
                    
                    multipartFormData.append(longitude.data(using: .utf8)!, withName: "coordinate[\"lon\"]")
                    multipartFormData.append(latitude.data(using: .utf8)!, withName: "coordinate[\"lat\"]")
                }
            }},
                         usingThreshold:UInt64.init(),
                         to: "\(localServiceAddress)/place/addPlace",
                         method: .post,
                         headers: ["Authorization": "auth_token"],
                         encodingCompletion: { encodingResult in
                            completion(encodingResult)
        })
    }
    
    
}
