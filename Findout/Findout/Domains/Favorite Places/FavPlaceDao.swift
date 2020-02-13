//
//  FavPlace.swift
//  Findout
//
//  Created by Ramzy Kermad on 19/12/2019.
//  Copyright © 2019 Ramzy Kermad. All rights reserved.
//

import Foundation


struct FavPlaceDao {
    var id: String = ""
    var userID: String = ""
    
    
    init(placeId: String, userId: String){
        self.id = placeId
        self.userID = userId
    }
}
