//
//  PlaceServices.swift
//  findout
//
//  Created by Ramzy Kermad on 18/12/2019.
//  Copyright © 2019 Ramzy Kermad. All rights reserved.
//

import Foundation

protocol PlaceServices{
    func getAll(completion: @escaping ([PlaceDao]) -> Void);
    func getById(_ id: String, completion: @escaping (PlaceDao?) -> Void);
    func create(place: PlaceDao);
}
