//
//  CategoriesMockServices.swift
//  Findout
//
//  Created by Ramzy Kermad on 23/12/2019.
//  Copyright © 2019 Ramzy Kermad. All rights reserved.
//

import Foundation

class CategoryMockServices: CategoryServices{
    
    private var categories: [CategoryDao] = [
        CategoryDao(name: "Sport", imageUrl: "", idCat: "1", idPlace: "1111"),
        CategoryDao(name: "Détente", imageUrl: "", idCat: "2", idPlace: "222"),
        CategoryDao(name: "Sortie", imageUrl: "", idCat: "3", idPlace: "333"),
        CategoryDao(name: "Restaurant", imageUrl: "", idCat: "4", idPlace: "4444"),
        CategoryDao(name: "Exposition", imageUrl: "", idCat: "5", idPlace: "5555"),
        CategoryDao(name: "Bar/café", imageUrl: "", idCat: "6", idPlace: "6666"),
        CategoryDao(name: "Plein air", imageUrl: "", idCat: "7", idPlace: "7777"),
    ]
    
    func getAll(completion: @escaping ([CategoryDao]) -> Void) {
        completion(categories)
    }
    
    func getById(_ id: String, completion: @escaping (CategoryDao?) -> Void) {
        completion(self.categories.first(where: { (r) -> Bool in
            return r.idCategory == id
        }))
    }
    
    func create(cat: CategoryDao) {
        //ee
    }
    
    
}
