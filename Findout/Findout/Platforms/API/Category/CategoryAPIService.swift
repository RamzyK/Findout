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
        let params = [
            "idActivity" : "lo"
        ]
        Alamofire.request("\(onlineServiceAddress)/getAll").responseJSON { (res) in
            guard let jsonCategory = res.result.value as? [String:Any] else {
                return
            }
            guard let categoryList = jsonCategory["category"] as? [[String:String]] else {
                return
            }
            var list : [CategoryDao] = []
            categoryList.forEach { (result) in
                guard let  id = result["_id"],
                    let idAct = result["id_activity"],
                    let name = result["name"],
                    let image = result["url_image"] else {
                        return
                }
                
                list.append(CategoryDao.init(name: name.capitalized, imageUrl: image, idCat: id, idActivity: idAct))
            }
            
            completion(list)
        }
    }
    
    func getById(_ id: String, completion: @escaping ([CategoryDao]) -> Void) {
        Alamofire.request("\(onlineServiceAddress)/getByIdActivity/\(id)").responseJSON { (res) in
            guard let jsonCategory = res.result.value as? [String:Any] else {
                return
            }
            guard let categoryList = jsonCategory["category"] as? [[String:String]] else {
                return
            }
            var list : [CategoryDao] = []
            categoryList.forEach { (result) in
                guard let  id = result["_id"],
                    let idAct = result["id_activity"],
                    let name = result["name"],
                    let image = result["url_image"] else {
                        return
                }
                
                list.append(CategoryDao.init(name: name.capitalized, imageUrl: image, idCat: id, idActivity: idAct))
            }
            
            completion(list)
        }
    }
    
    func create(cat: CategoryDao) {
        
    }
}
