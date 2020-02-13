//
//  DisponibilityServices.swift
//  Findout
//
//  Created by Ramzy Kermad on 19/12/2019.
//  Copyright © 2019 Ramzy Kermad. All rights reserved.
//

import Foundation

protocol DisponibilityServices {
    func getAll(completion: @escaping ([DisponibilityDao]) -> Void)
    func getByIdUser(idUser: String, completion: @escaping ([DisponibilityDao]) -> Void)
    func getByIdPlaceAndDate(placeId: String, date: String, completion: @escaping ([DisponibilityDao]) -> Void)
    func addDisponibility(id_place: String, id_user: String, startTime: String, endTime: String, date: String, nbPlace: String, completion: @escaping (Int) -> Void)
}
