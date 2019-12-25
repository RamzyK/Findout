//
//  SignupViewController.swift
//  Findout
//
//  Created by Ramzy Kermad on 23/12/2019.
//  Copyright © 2019 Ramzy Kermad. All rights reserved.
//

import UIKit

class SignupViewController: UIViewController {
    
    @IBOutlet var signupLabel: UILabel!
    @IBOutlet var nameLabel: UILabel!
    @IBOutlet var lastnameLabel: UILabel!
    @IBOutlet var emailLabel: UILabel!
    @IBOutlet var passwordLabel: UILabel!
    @IBOutlet var birthdateLabel: UILabel!
    @IBOutlet var phoneLabel: UILabel!
    
    @IBOutlet weak var userName: UITextField!
    @IBOutlet weak var userLastName: UITextField!
    @IBOutlet weak var userEmail: UITextField!
    @IBOutlet weak var userPassword: UITextField!
    @IBOutlet weak var userBirthDate: UITextField!
    @IBOutlet weak var userPhoneNumber: UITextField!
    
    @IBOutlet var signupButton: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.signupLabel.text = NSLocalizedString("signup.signupLabel", comment: "")
        self.nameLabel.text = NSLocalizedString("signup.nameLabel", comment: "")
        self.lastnameLabel.text = NSLocalizedString("signup.lastnameLabel", comment: "")
        self.emailLabel.text = NSLocalizedString("signup.emailLabel", comment: "")
        self.passwordLabel.text = NSLocalizedString("signup.passwordLabel", comment: "")
        self.birthdateLabel.text = NSLocalizedString("signup.birthdateLabel", comment: "")
        self.phoneLabel.text = NSLocalizedString("signup.phoneLabel", comment: "")
        self.signupButton.setTitle(NSLocalizedString("signup.signupButtonLabel", comment: ""), for: .normal)
        // TODO: METTRE LES CHAMPS DANS UNE SRCOLL VIEW POUR GERER L4APPARITION DU CLAVIER
        // Do any additional setup after loading the view.
    }

    @IBAction func signup(_ sender: Any) {
        // Sign user up
        // Create new user
    }
}
