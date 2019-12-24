//
//  Activity.swift
//  Findout
//
//  Created by Ramzy Kermad on 19/12/2019.
//  Copyright © 2019 Ramzy Kermad. All rights reserved.
//

import Foundation

protocol ActivityServices {
    func getAll(completion: @escaping ([ActivityDao]) -> Void);
    func create(cat: ActivityDao);
}

