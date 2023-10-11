//
//  RegisterVC.swift
//  FlashChat
//
//  Created by Марина on 17.09.2023.
//

import UIKit
import FirebaseAuth

class RegisterVC: UIViewController {
    
    private lazy var emailTextField: UITextField = {
        let textField = UITextField()
        textField.placeholder = "Email"
        textField.font = .systemFont(ofSize: 25)
        textField.backgroundColor = .white
        textField.layer.cornerRadius = 10
        textField.textAlignment = .center
        textField.clipsToBounds = true
        textField.translatesAutoresizingMaskIntoConstraints = false
        return textField
    }()
    
    private lazy var passwordTextField: UITextField = {
        let textField = UITextField()
        textField.placeholder = "Password"
        textField.font = .systemFont(ofSize: 25)
        textField.backgroundColor = .white
        textField.layer.cornerRadius = 10
        textField.textAlignment = .center
        textField.clipsToBounds = true
        textField.isSecureTextEntry = true
        textField.translatesAutoresizingMaskIntoConstraints = false
        return textField
    }()
    

    
    private lazy var registerButton: UIButton = {
        let button = UIButton(type: .system)
        button.setTitle("Register", for: .normal)
        button.tintColor = UIColor(named: "BrandBlue")
        button.backgroundColor = .clear
        button.titleLabel?.font = .systemFont(ofSize: 30)
        button.addTarget(self, action: #selector(registerButtonTapped), for: .touchUpInside)
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()

//    override func viewDidAppear(_ animated: Bool) {
//        super.viewDidAppear(animated)
//        emailTextField.becomeFirstResponder()
//    }
    override func viewDidLoad() {
        super.viewDidLoad()

        view.backgroundColor = UIColor(named: "BrandLightBlue")
        setupView()
        setConstraints()
        
        navigationItem.backButtonTitle = ""
    }
    private func   setupView() {
        view.addSubview(emailTextField)
        
        view.addSubview(passwordTextField)
        passwordTextField.textContentType = .oneTimeCode
        passwordTextField.autocorrectionType = .no
        view.addSubview(registerButton)
        emailTextField.becomeFirstResponder()
    }
    private func showAlert(_ e: String) {
        let alert = UIAlertController(title: e, message: nil, preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: NSLocalizedString("OK", comment: "Default action"), style: .default, handler: { _ in
        NSLog("The \"OK\" alert occured.")
        }))
        self.present(alert, animated: true, completion: nil)
    }
    @objc private func registerButtonTapped(_ sender: UIButton) {
        view.endEditing(true)
        if let email = emailTextField.text,
           let password = passwordTextField.text {
            Auth.auth().createUser(withEmail: email, password: password) { [ weak self] authResult, error in
                guard let self = self else { return }
                if let error = error {
                    if let error = error as NSError? {
                        if let authError = AuthErrorCode.Code(rawValue: error.code) {
                            switch authError {
                            case .invalidEmail:
                                self.showAlert("Email is invalid.")
                            case .emailAlreadyInUse:
                                self.showAlert("Email used to attempt sign up already exists")
                            case .weakPassword:
                                self.showAlert(error.userInfo[NSLocalizedFailureReasonErrorKey] as! String)
                            default:
                                self.showAlert("An unknowm error")
                            }
                        }
                    }
                    
                } else {
                    let chatVC = ChatVC()
                    self.navigationController?.pushViewController(chatVC, animated: true)
                }
            }
        }
        
      
    }
}

extension RegisterVC {
    private func setConstraints() {
        NSLayoutConstraint.activate([
            
            emailTextField.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20),
            emailTextField.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20),
            emailTextField.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 20),
            emailTextField.heightAnchor.constraint(equalTo: view.heightAnchor, multiplier: 0.06),


            passwordTextField.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20),
            passwordTextField.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20),
            passwordTextField.topAnchor.constraint(equalTo: emailTextField.bottomAnchor, constant: 10),
            passwordTextField.heightAnchor.constraint(equalTo: view.heightAnchor, multiplier: 0.06),
//            passwordTextField.widthAnchor.constraint(equalTo: view.widthAnchor, multiplier: 0.8)
            
            registerButton.topAnchor.constraint(equalTo: passwordTextField.bottomAnchor, constant: 10),
            registerButton.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20),
            registerButton.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20),

        ])
    }
}


