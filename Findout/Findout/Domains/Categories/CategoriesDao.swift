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
    var imageUrl: String = ""
    var idCategory: String
    var idPlaceList: String
    
    init?(jsonReponse: [String: Any]){
        self.name = ""
        self.idCategory = ""
        self.idPlaceList = ""
        guard let cat_name = jsonReponse["name"] as? String,
                let id_cat = jsonReponse["id"] as? String,
                let id_place = jsonReponse["id_place"] as? String else{
                return
        }
        self.name = cat_name
        self.idCategory = id_cat
        self.idPlaceList = id_place
        guard let cat_image = jsonReponse["image"] as? String else{
                return
        }
        self.imageUrl = cat_image
    }
    
    init(name: String,imageUrl: String ,idCat: String, idPlace: String){
        self.imageUrl = name
        self.imageUrl = imageUrl
        self.idCategory = idCat
        self.idPlaceList = idPlace
    }
}
