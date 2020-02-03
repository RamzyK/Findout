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
    var idCategory: String
    var idActivity: String
    var imageUrl: String
    
    init?(jsonReponse: [String: Any]){
        guard let name = jsonReponse["name"] as? String,
            let idCategory = jsonReponse["_id"] as? String,
            let idActivity = jsonReponse["id_activity"] as? String,
            let imageUrl = jsonReponse["url_image"] as? String else { return nil }

        self.name = name
        self.idCategory = idCategory
        self.idActivity = idActivity
        self.imageUrl = imageUrl
    }
 
    init(name: String, imageUrl: String ,idCat: String, idActivity: String){
        self.name = name
        self.imageUrl = imageUrl
        self.idCategory = idCat
        self.idActivity = idActivity
    }
}
