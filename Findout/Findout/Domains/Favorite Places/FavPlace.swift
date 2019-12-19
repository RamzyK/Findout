//
//  FavPlace.swift
//  Findout
//
//  Created by Ramzy Kermad on 19/12/2019.
//  Copyright © 2019 Ramzy Kermad. All rights reserved.
//

import Foundation


struct FavPlace {
    var id_place String = ""
    var id_user String = ""
    
    
    init(placeId: String, userId: String){
        self.id_place = placeId
        self.id_user = userId
    }
    
}
