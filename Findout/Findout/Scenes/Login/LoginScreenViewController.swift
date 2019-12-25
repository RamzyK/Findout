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
    @IBOutlet var welcomeLabel: UILabel!
    @IBOutlet var signinLabel: UILabel!
    @IBOutlet var signupButtonLabel: UIButton!
    @IBOutlet var passwordLabel: UILabel!
    @IBOutlet var emailLabel: UILabel!
    @IBOutlet var loginButton: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupView()
        setupNavigationBar()
        hideKeyboard()
        passwordTf.isSecureTextEntry = true
    }
    
    func setupView() {
        self.title = "FINDOUT"
        self.welcomeLabel.text = NSLocalizedString("login.welcomeLabel", comment: "")
        self.signinLabel.text = NSLocalizedString("login.signinLabel", comment: "")
        self.signupButtonLabel.setTitle(NSLocalizedString("login.signupButtonLabel", comment: ""), for: .normal)
        self.passwordLabel.text = NSLocalizedString("login.passwordLabel", comment: "")
        self.emailLabel.text = NSLocalizedString("login.emailLabel", comment: "")
        self.loginButton.setTitle( NSLocalizedString("login.loginButtonLabel", comment: ""), for: .normal)
    }
    
    func setupNavigationBar() {
        self.navigationController?.navigationBar.barTintColor = #colorLiteral(red: 0.2193810642, green: 0.7583789825, blue: 0.4023743272, alpha: 1)
        self.navigationController?.navigationBar.titleTextAttributes = [.foregroundColor: UIColor.white]
    }
    
    func hideKeyboard() {
        let tap = UITapGestureRecognizer(target: self, action: #selector(dismissKeyboard))
        view.addGestureRecognizer(tap)
    }

    @objc
    func dismissKeyboard() {
        view.endEditing(true)
    }
    
    @IBAction func goToSignup(_ sender: Any) {
        self.present(SignupViewController(), animated: true, completion: nil)
    }
    
    @IBAction func login(_ sender: Any) {
        self.navigationController?.pushViewController(ActivityViewController(), animated: true)
    }
}
