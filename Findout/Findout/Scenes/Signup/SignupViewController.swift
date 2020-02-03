//
//  SignupViewController.swift
//  Findout
//
//  Created by Ramzy Kermad on 23/12/2019.
//  Copyright © 2019 Ramzy Kermad. All rights reserved.
//

import UIKit

class SignupViewController: UIViewController {
    
    @IBOutlet var scrollView: UIScrollView!
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
    
    var datePickerView = UIView()
    var selectedDate = ""
    var isBirthdateClicked = false
    var loginViewController = LoginScreenViewController()

    var userServices: UserServices {
        return UserAPIService()
    }

    class func newInstance(loginController: LoginScreenViewController) -> SignupViewController {
        let svc = SignupViewController()
        svc.loginViewController = loginController
        return svc
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        setupView()
        hideKeyboardAndDatePicker()
        setupCloseButton()
        setTextFieldDelegates()
    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        addObservers()
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        removeObserver()
    }

    @IBAction func signup(_ sender: Any) {
        // Sign user up
        // Create new user
        if(isFormFilled()){
            let loaderAlert = UIAlertController(title: nil,
                                          message: NSLocalizedString("login.loadingMessage", comment: ""),
                                          preferredStyle: .alert)

            let loadingIndicator = UIActivityIndicatorView(frame: CGRect(x: 10, y: 5, width: 50, height: 50))
            loadingIndicator.hidesWhenStopped = true
            loadingIndicator.style = UIActivityIndicatorView.Style.medium
            loadingIndicator.startAnimating();

            loaderAlert.view.addSubview(loadingIndicator)
            self.present(loaderAlert, animated: true, completion: nil)
            let user = UserDao(id: "", firstname: userName.text!, lastname: userLastName.text!, birthDate: userBirthDate.text!, email: userEmail.text!, tel: userPhoneNumber.text!)
            userServices.addUser(user: user, password: userPassword.text!) { (user, error) in
                switch(error) {
                    case 200:
                        loaderAlert.dismiss(animated: true){
                            self.loginViewController.navigationController?.pushViewController(ActivityViewController(), animated: true)
                            self.dismissScreen()
                        }
                        break
                    case 400:
                        loaderAlert.dismiss(animated: true, completion: nil)
                        self.errorAlert(message: "L'adresse mail est déjà utilisé")
                        break
                    default:
                        loaderAlert.dismiss(animated: true, completion: nil)
                        self.errorAlert(message: "Erreur serveur, veuillez réessayer")
                        break
                }
            }
        }else{
            self.errorAlert(message:"Please fill the obligatory fields")
        }
    }
    
    private func setTextFieldDelegates() {
        self.userName.delegate = self
        self.userLastName.delegate = self
        self.userEmail.delegate = self
        self.userPassword.delegate = self
        self.userBirthDate.delegate = self
        self.userPhoneNumber.delegate = self
    }

    private func isFormFilled() -> Bool {
        guard let nameText = userName.text,
            let lastnameText = userLastName.text,
            let passwordText = userPassword.text,
            let emailText = userEmail.text,
            let birthdate = self.userBirthDate.text,
            let phone = self.userPhoneNumber.text else{
                return false
        }

        if(nameText.count > 0 && lastnameText.count > 0
        && emailText.count > 0 && passwordText.count > 0
        && birthdate.count > 0 && phone.count > 0
        && emailText.isEmailValid() && passwordText.isPasswordValid()){
            return true
        }else{
            checkOnWichTextFieldIsError()
        }
        return false
    }
        
    private func checkOnWichTextFieldIsError() {
        if(userName.text!.count == 0){
            userName.isError(baseColor: #colorLiteral(red: 0.8078431487, green: 0.02745098062, blue: 0.3333333433, alpha: 1), numberOfShakes: 3.0, revert: true)
        }
        if(userLastName.text!.count == 0){
            userLastName.isError(baseColor: #colorLiteral(red: 0.8078431487, green: 0.02745098062, blue: 0.3333333433, alpha: 1), numberOfShakes: 3.0, revert: true)
        }
        
        if(userPassword.text!.count == 0){
            userPassword.isError(baseColor: #colorLiteral(red: 0.8078431487, green: 0.02745098062, blue: 0.3333333433, alpha: 1), numberOfShakes: 3.0, revert: true)
        }
        if(userEmail.text!.count == 0){
            userEmail.isError(baseColor: #colorLiteral(red: 0.8078431487, green: 0.02745098062, blue: 0.3333333433, alpha: 1), numberOfShakes: 3.0, revert: true)
        }

        if(userBirthDate.text!.count == 0){
            userBirthDate.isError(baseColor: #colorLiteral(red: 0.8078431487, green: 0.02745098062, blue: 0.3333333433, alpha: 1), numberOfShakes: 3.0, revert: true)
        }
        if(userPhoneNumber.text!.count == 0){
            userPhoneNumber.isError(baseColor: #colorLiteral(red: 0.8078431487, green: 0.02745098062, blue: 0.3333333433, alpha: 1), numberOfShakes: 3.0, revert: true)
        }
    }
    
    func addObservers() {
        NotificationCenter.default.addObserver(forName: UIResponder.keyboardWillHideNotification, object: nil, queue: nil) { notification in
            self.keyboardWillHide(notification: notification)
        }
        NotificationCenter.default.addObserver(forName: UIResponder.keyboardWillShowNotification, object: nil, queue: nil) { notification in
            self.keyboardWillShow(notification: notification)
        }
    }
    
    func removeObserver() {
        NotificationCenter.default.removeObserver(self)
    }
    
    func keyboardWillShow(notification: Notification) {
        guard let userInfo = notification.userInfo,
            let frame = (userInfo[UIResponder.keyboardFrameEndUserInfoKey] as? NSValue)?.cgRectValue else {
                return
        }
        let contentInset = UIEdgeInsets(top: 0, left: 0, bottom: frame.height, right: 0)
        scrollView.contentInset = contentInset
    }
    
    func keyboardWillHide(notification: Notification) {
        scrollView.contentInset = UIEdgeInsets.zero
    }
    
    func hideKeyboardAndDatePicker() {
        let tapView = UITapGestureRecognizer(target: self, action: #selector(dismissKeyboardAndDatePicker))
        view.addGestureRecognizer(tapView)
    }

    func setupView() {
        self.setupTextFieldKeyboardTypes()
        self.setupLabelTitle()
        self.signupButton.layer.cornerRadius = 8
    }

    func setupTextFieldKeyboardTypes() {
        self.userName.keyboardType = .alphabet
        self.userLastName.keyboardType = .alphabet
        self.userEmail.keyboardType = .emailAddress
        self.userPassword.keyboardType = .default
        self.userPhoneNumber.keyboardType = .decimalPad
        self.userPassword.isSecureTextEntry = true
    }

    func setupLabelTitle() {
        self.signupLabel.text = NSLocalizedString("signup.signupLabel", comment: "")
        self.nameLabel.text = NSLocalizedString("signup.nameLabel", comment: "")
        self.lastnameLabel.text = NSLocalizedString("signup.lastnameLabel", comment: "")
        self.emailLabel.text = NSLocalizedString("signup.emailLabel", comment: "")
        self.passwordLabel.text = NSLocalizedString("signup.passwordLabel", comment: "")
        self.birthdateLabel.text = NSLocalizedString("signup.birthdateLabel", comment: "")
        self.phoneLabel.text = NSLocalizedString("signup.phoneLabel", comment: "")
        self.signupButton.setTitle(NSLocalizedString("signup.signupButtonLabel", comment: ""), for: .normal)
    }

    func setupBirthdateDatePicker() {
        if !self.isBirthdateClicked {
            // Posiiton date picket within a view
            self.datePickerView = UIView()
            self.datePickerView.frame = CGRect(x: 0, y: UIScreen.main.bounds.maxY, width: self.view.frame.width, height: 220)

            let dateFormatter: DateFormatter = DateFormatter()
            dateFormatter.dateFormat = "dd/MM/yyyy"

            let datePicker = UIDatePicker()
            datePicker.frame = CGRect(x: 0, y: 20, width: self.view.frame.width, height: 200)
            datePicker.datePickerMode = .date

            // Set some of UIDatePicker properties
           datePicker.timeZone = NSTimeZone.local
           datePicker.backgroundColor = UIColor.white
            if self.selectedDate != "" {
                datePicker.setDate(dateFormatter.date(from: self.selectedDate)!, animated: true)
            }
           // Add an event to call onDidChangeDate function when value is changed.
            datePicker.addTarget(self, action: #selector(self.datePickerValueChanged(_:)), for: .valueChanged)

            // ToolBar
            let toolBar = UIToolbar()
            toolBar.frame = CGRect(x: 0, y: 0, width: datePicker.frame.width, height: 20)
            toolBar.barStyle = .default
            toolBar.barTintColor = UIColor.white
            toolBar.isTranslucent = true
            toolBar.sizeToFit()

            // Adding Button ToolBar
            let doneButton = UIBarButtonItem(title: "Next", style: .plain, target: self, action: #selector(self.doneClick))
            let spaceButton = UIBarButtonItem(barButtonSystemItem: .flexibleSpace, target: nil, action: nil)
            toolBar.setItems([spaceButton, doneButton], animated: false)
            toolBar.isUserInteractionEnabled = true
            self.datePickerView.addSubview(datePicker)
            self.datePickerView.addSubview(toolBar)
            self.view.addSubview(self.datePickerView)
           // Add DataPicker to the view with animation
            UIView.animate(withDuration: 0.5, animations: {
                self.datePickerView.frame.origin.y -= 300
            }, completion: nil)
        }
    }

    func setupCloseButton() {
        let closeButton = UIButton(frame: CGRect(x: 5, y: 40, width: 40, height: 40))
        closeButton.setTitle("\u{2715}", for: .normal)
        closeButton.setTitleColor(UIColor.black, for: .normal)
        closeButton.addTarget(self, action: #selector(dismissScreen), for: .touchUpInside)
        closeButton.backgroundColor = UIColor.clear
        self.scrollView.addSubview(closeButton)
    }
    
    func addToolBarToPhoneNumberPad() {
        let toolbarDone = UIToolbar()
        toolbarDone.sizeToFit()
        let barBtnDone = UIBarButtonItem(barButtonSystemItem: .done,
                target: self, action: #selector(self.finishEditing))
        let spaceButton = UIBarButtonItem(barButtonSystemItem: .flexibleSpace, target: nil, action: nil)
        toolbarDone.items = [spaceButton, barBtnDone]
        self.userPhoneNumber.inputAccessoryView = toolbarDone
    }

    @objc
    func dismissScreen() {
        self.dismiss(animated: true) {
        }
    }
    
    @objc
    func dismissKeyboardAndDatePicker() {
        // Add DataPicker to the view
        UIView.animate(withDuration: 0.5, animations: {
            self.view.endEditing(true)
            self.datePickerView.frame.origin.y += 300
        }) { (result) in
            if result && self.isBirthdateClicked{
                self.isBirthdateClicked = false
                if(self.userBirthDate.text!.count > 0){
                    self.userBirthDate.layer.shadowOffset.height = 0
                }
                if(self.userBirthDate.text!.count == 0){
                    self.userBirthDate.isError(baseColor: #colorLiteral(red: 0.8078431487, green: 0.02745098062, blue: 0.3333333433, alpha: 1), numberOfShakes: 3.0, revert: true)
                }
                self.datePickerView.removeFromSuperview()
            }
        }
    }

    @objc
    func datePickerValueChanged(_ sender: UIDatePicker) {
        let dateFormatter: DateFormatter = DateFormatter()
        dateFormatter.dateFormat = "dd/MM/yyyy"
        let selectedDate: String = dateFormatter.string(from: sender.date)
        self.selectedDate = selectedDate
    }

    @objc
    func doneClick() {
        self.userBirthDate.text = self.selectedDate
        self.dismissKeyboardAndDatePicker()
        self.userPhoneNumber.becomeFirstResponder()
    }

    @objc
    func finishEditing() {
        self.dismissKeyboardAndDatePicker()
        self.signup(self)
    }
}


extension SignupViewController: UITextFieldDelegate {
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        switch textField {
        case self.userName:
            self.userLastName.becomeFirstResponder()
            break
        case self.userLastName:
            self.userEmail.becomeFirstResponder()
            break
        case self.userEmail:
            self.userPassword.becomeFirstResponder()
            break
        case self.userPassword:
            self.userBirthDate.becomeFirstResponder()
            break
        case self.userBirthDate:
            self.userPhoneNumber.becomeFirstResponder()
            break
        case self.userPhoneNumber:
            self.userPhoneNumber.resignFirstResponder()
            break
        default:
            break
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
        case self.userName:
            if(userName.text!.count > 0){
                userName.layer.shadowOffset.height = 0
            } else {
                userName.isError(baseColor: #colorLiteral(red: 0.8078431487, green: 0.02745098062, blue: 0.3333333433, alpha: 1), numberOfShakes: 3.0, revert: true)
            }
            break
        case self.userLastName:
            if(userLastName.text!.count > 0){
                userLastName.layer.shadowOffset.height = 0
            } else {
                userLastName.isError(baseColor: #colorLiteral(red: 0.8078431487, green: 0.02745098062, blue: 0.3333333433, alpha: 1), numberOfShakes: 3.0, revert: true)
            }
            break
        case self.userEmail:
            if(userEmail.text!.count > 0 && userEmail.text!.isEmailValid()){
                userEmail.layer.shadowOffset.height = 0
            } else {
                userEmail.isError(baseColor: #colorLiteral(red: 0.8078431487, green: 0.02745098062, blue: 0.3333333433, alpha: 1), numberOfShakes: 3.0, revert: true)
            }
            break
        case self.userPassword:
            if(userPassword.text!.count > 0 && userPassword.text!.isPasswordValid()){
                userPassword.layer.shadowOffset.height = 0
            } else {
                userPassword.isError(baseColor: #colorLiteral(red: 0.8078431487, green: 0.02745098062, blue: 0.3333333433, alpha: 1), numberOfShakes: 3.0, revert: true)
            }
            break
        case self.userPhoneNumber:
            if(userPhoneNumber.text!.count > 0){
                userPhoneNumber.layer.shadowOffset.height = 0
            } else {
                userPhoneNumber.isError(baseColor: #colorLiteral(red: 0.8078431487, green: 0.02745098062, blue: 0.3333333433, alpha: 1), numberOfShakes: 3.0, revert: true)
            }
            break
        default:
            break
        }
    }
    
    func textFieldShouldBeginEditing(_ textField: UITextField) -> Bool {
        switch textField {
            case self.userBirthDate:
                self.view.endEditing(true)
                setupBirthdateDatePicker()
                self.isBirthdateClicked = true
                return false
            case self.userPhoneNumber:
                self.addToolBarToPhoneNumberPad()
                return true
        default:
            return true
        }
    }

}
