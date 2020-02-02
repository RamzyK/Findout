//
//  StringExtension.swift
//  Findout
//
//  Created by Nassim Morouche on 08/01/2020.
//  Copyright © 2020 Ramzy Kermad. All rights reserved.
//

import Foundation

extension String {

    func isEmailValid() -> Bool {
        let emailRegEx = "[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,64}"

        let emailPred = NSPredicate(format:"SELF MATCHES %@", emailRegEx)
        return emailPred.evaluate(with: self)
    }

    func isPasswordValid() -> Bool {
        if self.count < 4 || self.count > 20 || containsNonAlphaNumeric() {
            return false
        }
        return true
    }

    func containsNonAlphaNumeric() -> Bool {
        let characterset = CharacterSet.alphanumerics
        if self.rangeOfCharacter(from: characterset.inverted) != nil {
            return true
        }
        return false
    }
}
