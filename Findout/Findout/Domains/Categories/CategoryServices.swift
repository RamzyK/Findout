//
//  CategoryServices.swift
//  Findout
//
//  Created by Ramzy Kermad on 19/12/2019.
//  Copyright © 2019 Ramzy Kermad. All rights reserved.
//

import Foundation

protocol CategoryServices {
    func getAll(completion: @escaping ([CategoryDao]) -> Void);
}
