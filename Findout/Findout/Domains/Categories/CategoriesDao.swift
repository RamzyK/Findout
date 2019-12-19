//
//  CategoriesDao.swift
//  Findout
//
//  Created by Ramzy Kermad on 19/12/2019.
//  Copyright © 2019 Ramzy Kermad. All rights reserved.
//

import Foundation

struct CategoryDao {
    // Représente 1 type d'activité
    
    var name: String
    var id_category: String
    var id_place_list: String
    
    init?(jsonReponse: [String: Any]){
        self.name = ""
        self.id_category = ""
        self.id_place_list = ""
        guard let cat_name = jsonReponse["name"] as? String,
                let id_cat = jsonReponse["id"] as? String,
                let id_place = jsonReponse["id_place"] as? String else{
                return
        }
        self.name = cat_name
        self.id_category = id_cat
        self.id_place_list = id_place
    }
    
    init(name: String, idCat: String, idPlace: String){
        self.name = name
        self.id_category = idCat
        self.id_place_list = idPlace
    }
}
