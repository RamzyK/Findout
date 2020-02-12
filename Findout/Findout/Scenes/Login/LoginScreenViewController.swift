//
//  LoginScreenViewController.swift
//  Findout
//
//  Created by Ramzy Kermad on 19/12/2019.
//  Copyright © 2019 Ramzy Kermad. All rights reserved.
//

import UIKit

class LoginScreenViewController: UIViewController {
    
    // MARK: - VARIABLES
    @IBOutlet weak var emailTf: UITextField!
    @IBOutlet weak var passwordTf: UITextField!
    @IBOutlet var welcomeLabel: UILabel!
    @IBOutlet var signinLabel: UILabel!
    @IBOutlet var signupButtonLabel: UIButton!
    @IBOutlet var passwordLabel: UILabel!
    @IBOutlet var emailLabel: UILabel!
    @IBOutlet var loginButton: UIButton!
    
    var userServices: UserServices{
        return UserAPIService()
    }
    
    // MARK: - OVERRIDE
    override func viewDidLoad() {
        super.viewDidLoad()
        setupView()
        setupNavigationBar()
        hideKeyboard()
        passwordTf.isSecureTextEntry = true
        
        emailTf.delegate = self
        passwordTf.delegate = self
    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)

    }

    // MARK: - SETUP
    func setupView() {
        self.title = NSLocalizedString("app.name", comment: "")
        self.welcomeLabel.text = NSLocalizedString("login.welcomeLabel", comment: "")
        self.signinLabel.text = NSLocalizedString("login.signinLabel", comment: "")
        self.signupButtonLabel.setTitle(NSLocalizedString("login.signupButtonLabel", comment: ""), for: .normal)
        self.passwordLabel.text = NSLocalizedString("login.passwordLabel", comment: "")
        self.emailLabel.text = NSLocalizedString("login.emailLabel", comment: "")
        self.loginButton.setTitle( NSLocalizedString("login.loginButtonLabel", comment: ""), for: .normal)
        self.loginButton.layer.cornerRadius = 8
    }
    
    func setupNavigationBar() {
        self.navigationController?.navigationBar.barTintColor = #colorLiteral(red: 0.2193810642, green: 0.7583789825, blue: 0.4023743272, alpha: 1)
        self.navigationController?.navigationBar.titleTextAttributes = [.foregroundColor: UIColor.white]
        self.navigationItem.setHidesBackButton(true, animated:true);
    }
    
    // MARK: - ACTIONS
    @IBAction func goToSignup(_ sender: Any) {
        self.present(SignupViewController.newInstance(loginController: self), animated: true, completion: nil)
    }
    
    @IBAction func login(_ sender: Any) {
        if(isFormFilled()){
            let loaderAlert = UIAlertController(title: nil,
                                          message: NSLocalizedString("login.loadingMessage", comment: ""),
                                          preferredStyle: .alert)

            let loadingIndicator = UIActivityIndicatorView(frame: CGRect(x: 10, y: 5, width: 50, height: 50))
            loadingIndicator.hidesWhenStopped = true
            loadingIndicator.style = UIActivityIndicatorView.Style.medium
            loadingIndicator.startAnimating();

            loaderAlert.view.addSubview(loadingIndicator)
            present(loaderAlert, animated: true, completion: nil)
            
            userServices.connect(email: self.emailTf.text!, password: self.passwordTf.text!) { (user, status) in
                if status == 200{
                    loaderAlert.dismiss(animated: true){
                        UserDefaults.standard.set(user?.userID, forKey: "userID")
                        self.navigationController?.pushViewController(ActivityViewController(), animated: true)
                    }
                }else{
                    loaderAlert.dismiss(animated: true){
                        self.errorAlert(message: NSLocalizedString("error.user.exist", comment: ""))
                    }
                }
            }
        }
    }
    
    
    // MARK: - UTILS
    
    func hideKeyboard() {
        let tap = UITapGestureRecognizer(target: self, action: #selector(dismissKeyboard))
        view.addGestureRecognizer(tap)
    }

    @objc
    func dismissKeyboard() {
        view.endEditing(true)
    }
    
    private func isFormFilled() -> Bool {
        guard let emailText = emailTf.text,
            let passwordText = passwordTf.text else{
                return false
        }
        if(emailText.count > 0 && passwordText.count > 0 && emailText.isEmailValid() && passwordText.isPasswordValid()){ 
            return true
        }else{
            checkOnWichTextFieldIsError()
        }
        return false
    }
    
    private func checkOnWichTextFieldIsError(){
        if(emailTf.text!.count == 0 || !emailTf.text!.isEmailValid()){
            emailTf.isError(baseColor: #colorLiteral(red: 0.8078431487, green: 0.02745098062, blue: 0.3333333433, alpha: 1), numberOfShakes: 3.0, revert: true)
        }
        if(passwordTf.text!.count == 0 || !passwordTf.text!.isPasswordValid()){
            passwordTf.isError(baseColor: #colorLiteral(red: 0.8078431487, green: 0.02745098062, blue: 0.3333333433, alpha: 1), numberOfShakes: 3.0, revert: true)
        }
    }
}


extension LoginScreenViewController: UITextFieldDelegate {
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        if textField == self.emailTf {
            self.passwordTf.becomeFirstResponder() // open keyboard
        } else if textField == self.passwordTf {
            self.passwordTf.resignFirstResponder() // close keyboard
        }
        return true
    }
    
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        if (string == " ") {
            return false
        }
        return true
    }

    // Check error
    func textFieldDidEndEditing(_ textField: UITextField) {
        switch textField {
        case emailTf:
            if(emailTf.text!.count > 0 && emailTf.text!.isEmailValid()){
                emailTf.layer.shadowOffset.height = 0
            } else {
                emailTf.isError(baseColor: #colorLiteral(red: 0.8078431487, green: 0.02745098062, blue: 0.3333333433, alpha: 1), numberOfShakes: 3.0, revert: true)
            }
            break
        case passwordTf:
            if(passwordTf.text!.count > 0 && passwordTf.text!.isPasswordValid()){
                passwordTf.layer.shadowOffset.height = 0
            } else {
                passwordTf.isError(baseColor: #colorLiteral(red: 0.8078431487, green: 0.02745098062, blue: 0.3333333433, alpha: 1), numberOfShakes: 3.0, revert: true)
            }
            break
        default:
            break
        }
    }
}
