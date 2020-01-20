//
//  UIViewControllerExtension.swift
//  Findout
//
//  Created by Nassim Morouche on 07/01/2020.
//  Copyright © 2020 Ramzy Kermad. All rights reserved.
//

import UIKit

extension UIViewController {

    func errorAlert(message : String) {
        let alertWarn = UIAlertController(title: "Warning", message: message, preferredStyle: .alert)
        alertWarn.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
        self.present(alertWarn, animated: true, completion: nil)
    }
}
