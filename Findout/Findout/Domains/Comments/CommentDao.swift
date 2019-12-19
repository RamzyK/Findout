//
//  CommentDao.swift
//  Findout
//
//  Created by Ramzy Kermad on 19/12/2019.
//  Copyright © 2019 Ramzy Kermad. All rights reserved.
//

import Foundation

struct CommentDao {
    var comment: String = ""
    var score: Int = 0
    var userID = ""
    var placeID = ""
    
    init?(jsonResponse: [String: Any]){
        guard let message = jsonResponse["message"] as? String,
                let score = jsonResponse["score"] as? Int,
                let user_id = jsonResponse["user_id"] as? String,
            let place_id = jsonResponse["place_id"] as? String else{
                return
        }
        self.comment = message
        self.score = score
        self.userID = user_id
        self.placeID = place_id
    }
    
    init(message: String, score: Int, userId: String, placeId: String){
        self.comment = message
        self.score = score
        self.userID = userId
        self.placeID = placeId
    }
}
