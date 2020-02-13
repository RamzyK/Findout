//
//  CategoryAPIService.swift
//  Findout
//
//  Created by Vithursan Sivakumaran on 06/01/2020.
//  Copyright © 2020 Ramzy Kermad. All rights reserved.
//

import Foundation
import Alamofire

class CategoryAPIService : CategoryServices{
    let localServiceAddress = "http://localhost:3000/category"
    let onlineServiceAddress = "https://findout-esgi.herokuapp.com/category"
    
    public static let `default` = CategoryAPIService()
    
    func getAll(completion: @escaping ([CategoryDao]) -> Void) {
        Alamofire.request("\(onlineServiceAddress)/getAll").responseJSON { (res) in
            guard let jsonCategory = res.result.value as? [String: Any],
                let categoryList = jsonCategory["category"] as? [[String: Any]] else { return }
                let list = categoryList.compactMap({ (elem) -> CategoryDao? in
                    return CategoryDao.init(jsonReponse: elem)
                })
            completion(list)
        }
    }
}
