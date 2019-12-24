//
//  LoginScreenViewController.swift
//  Findout
//
//  Created by Ramzy Kermad on 19/12/2019.
//  Copyright © 2019 Ramzy Kermad. All rights reserved.
//

import UIKit

class LoginScreenViewController: UIViewController {
    
    @IBOutlet weak var emailTf: UITextField!
    @IBOutlet weak var passwordTf: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.title = "FINDOUT"
        self.navigationController?.navigationBar.barTintColor = #colorLiteral(red: 0.2193810642, green: 0.7583789825, blue: 0.4023743272, alpha: 1)
        self.navigationController?.navigationBar.titleTextAttributes = [.foregroundColor: UIColor.white]
        
        passwordTf.isSecureTextEntry = true
    }
    
    @IBAction func goToSignup(_ sender: Any) {
        self.present(SignupViewController(), animated: true, completion: nil)
    }
    
    @IBAction func login(_ sender: Any) {
        self.navigationController?.pushViewController(ActivityViewController(), animated: true)
    }
}
