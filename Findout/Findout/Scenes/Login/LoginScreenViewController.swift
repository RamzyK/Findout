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
        
        emailTf.delegate = self
        passwordTf.delegate = self
    }
    var userServices: UserServices{
        return UserMockServices()
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
        if(isFormFilled()){
            UserAPIService.default.connect(email: self.emailTf.text!, password: self.passwordTf.text!) { (user) in
                print("log : \(user)")
                if(user.userID != "") {
                    self.navigationController?.pushViewController(ActivityViewController(), animated: true)
                } else {
                    print("User does not exist!")
                    self.warningAlert(message: "User does not exist!")
                }
            }
        }else{
            print("User does not exist!")
            self.warningAlert(message: "User does not exist!")
        }
    }
    
    private func checkIfUserExist() -> Bool{
        var userExist = false
        if(isFormFilled()){
            userServices.getAll { (users) in
                let userInMocks = users.first(where: { (r) -> Bool in
                    return r.email == self.emailTf.text
                })
                if(userInMocks != nil){
                    userExist = true
                }else{
                    userExist = false
                }
            }
        }else{
            print("U must fill all the form befor signin")
            self.warningAlert(message: "U must fill all the form befor signin")
        }
        return userExist
    }
    
    private func isFormFilled() -> Bool{
        guard let emailText = emailTf.text,
            let passwordText = passwordTf.text else{
                return false
        }
        if(emailText.count > 0 && passwordText.count > 0){
            return true
        }else{
            checkOnWichTextFieldIsError()
        }
        return false
    }
    
    private func checkOnWichTextFieldIsError(){
        if(emailTf.text!.count == 0){
            emailTf.isError(baseColor: #colorLiteral(red: 0.8078431487, green: 0.02745098062, blue: 0.3333333433, alpha: 1), numberOfShakes: 3.0, revert: true)
        }
        if(passwordTf.text!.count == 0){
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
    
    // Check error
    func textFieldDidEndEditing(_ textField: UITextField) {
        switch textField {
        case emailTf:
            if(emailTf.text!.count > 0){
                emailTf.layer.shadowOffset.height = 0
            }
            break
        case passwordTf:
            if(passwordTf.text!.count > 0){
                passwordTf.layer.shadowOffset.height = 0
            }
            break
        default:
            break
        }
    }
    
    func warningAlert(message : String) {
        let alertWarn = UIAlertController(title: "Warning", message: message, preferredStyle: .alert)
        alertWarn.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
        self.present(alertWarn, animated: true, completion: nil)
    }
    
}




extension UITextField {
    
    func isError(baseColor: CGColor, numberOfShakes shakes: Float, revert: Bool) {
        self.layer.shadowColor = baseColor
        self.layer.shadowOffset = CGSize(width: 0.0, height: 2.0)
        self.layer.shadowOpacity = 1.0
        self.layer.shadowRadius = 0.0
        
        let animation: CABasicAnimation = CABasicAnimation(keyPath: "shadowColor")
        animation.fromValue = baseColor
        animation.toValue = UIColor.red.cgColor
        animation.duration = 0.4
        if revert { animation.autoreverses = true } else { animation.autoreverses = false }
        self.layer.add(animation, forKey: "")

        let shake: CABasicAnimation = CABasicAnimation(keyPath: "position")
        shake.duration = 0.07
        shake.repeatCount = shakes
        if revert { shake.autoreverses = true  } else { shake.autoreverses = false }
        shake.fromValue = NSValue(cgPoint: CGPoint(x: self.center.x - 10, y: self.center.y))
        shake.toValue = NSValue(cgPoint: CGPoint(x: self.center.x + 10, y: self.center.y))
        self.layer.add(shake, forKey: "position")
    }
}
