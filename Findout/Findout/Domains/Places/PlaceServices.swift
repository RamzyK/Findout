//
//  PlaceServices.swift
//  findout
//
//  Created by Ramzy Kermad on 18/12/2019.
//  Copyright © 2019 Ramzy Kermad. All rights reserved.
//

import Foundation
import UIKit
import Alamofire

protocol PlaceServices{
    func getAll(completion: @escaping ([PlaceDao]) -> Void);
    func getById(id: String, completion: @escaping ([PlaceDao]) -> Void);
    func create(params: [String:Any], image: UIImage, completion: @escaping (SessionManager.MultipartFormDataEncodingResult) -> Void);
}
