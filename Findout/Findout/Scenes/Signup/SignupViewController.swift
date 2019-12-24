//
//  SignupViewController.swift
//  Findout
//
//  Created by Ramzy Kermad on 23/12/2019.
//  Copyright © 2019 Ramzy Kermad. All rights reserved.
//

import UIKit

class SignupViewController: UIViewController {

    @IBOutlet weak var userName: UITextField!
    @IBOutlet weak var userLastName: UITextField!
    @IBOutlet weak var userEmail: UITextField!
    @IBOutlet weak var userPassword: UITextField!
    @IBOutlet weak var userBirthDate: UITextField!
    @IBOutlet weak var userPhoneNumber: UITextField!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // TODO: METTRE LES CHAMPS DANS UNE SRCOLL VIEW POUR GERER L4APPARITION DU CLAVIER
        // Do any additional setup after loading the view.
    }

    @IBAction func signup(_ sender: Any) {
        // Sign user up
        // Create new user
    }
}
