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
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupView()
        hideKeyboard()
        setupCloseButton()
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
    }
    
    func setupView() {
        self.signupLabel.text = NSLocalizedString("signup.signupLabel", comment: "")
        self.nameLabel.text = NSLocalizedString("signup.nameLabel", comment: "")
        self.lastnameLabel.text = NSLocalizedString("signup.lastnameLabel", comment: "")
        self.emailLabel.text = NSLocalizedString("signup.emailLabel", comment: "")
        self.passwordLabel.text = NSLocalizedString("signup.passwordLabel", comment: "")
        self.birthdateLabel.text = NSLocalizedString("signup.birthdateLabel", comment: "")
        self.phoneLabel.text = NSLocalizedString("signup.phoneLabel", comment: "")
        self.signupButton.setTitle(NSLocalizedString("signup.signupButtonLabel", comment: ""), for: .normal)
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
    
    func hideKeyboard() {
        let tap = UITapGestureRecognizer(target: self, action: #selector(dismissKeyboard))
        view.addGestureRecognizer(tap)
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
    
    func setupCloseButton() {
        let closeButton = UIButton(frame: CGRect(x: 5, y: 40, width: 40, height: 40))
        closeButton.setTitle("\u{2715}", for: .normal)
        closeButton.setTitleColor(UIColor.black, for: .normal)
        closeButton.addTarget(self, action: #selector(dismissScreen), for: .touchUpInside)
        closeButton.backgroundColor = UIColor.clear
        self.scrollView.addSubview(closeButton)
    }
    
    @objc
    func dismissScreen() {
        self.dismiss(animated: true) {
        }
    }
    
    @objc
    func dismissKeyboard() {
        view.endEditing(true)
    }
}
