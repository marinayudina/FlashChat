//
//  LogInVC.swift
//  FlashChat
//
//  Created by Марина on 17.09.2023.
//

import UIKit
import FirebaseAuth

class LogInVC: UIViewController {

    private lazy var emailTextField: UITextField = {
        let textField = UITextField()
        textField.placeholder = "Email"
        textField.font = .systemFont(ofSize: 25)
        textField.backgroundColor = .white
        textField.layer.cornerRadius = 10
        textField.textAlignment = .center
        textField.clipsToBounds = true
        textField.text = "0518204@mail.ru"
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
        textField.text = "mari22"
        textField.clipsToBounds = true
        textField.isSecureTextEntry = true
        textField.translatesAutoresizingMaskIntoConstraints = false
        return textField
    }()
    
    
    private lazy var logButton: UIButton = {
        let button = UIButton(type: .system)
        button.setTitle("Log in", for: .normal)
        button.tintColor = .white
        button.backgroundColor = .clear
        button.titleLabel?.font = .systemFont(ofSize: 30)
        button.addTarget(self, action: #selector(logButtonTapped), for: .touchUpInside)
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()

    override func viewDidLoad() {
        super.viewDidLoad()

        view.backgroundColor = .systemCyan
        setupView()
        setConstraints()
        
        navigationItem.backButtonTitle = ""


    }
    private func   setupView() {
        view.addSubview(emailTextField)
        
        view.addSubview(passwordTextField)
        view.addSubview(logButton)
    }
    
    private func showAlert(_ e: String) {
        let alert = UIAlertController(title: e, message: nil, preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: NSLocalizedString("OK", comment: "Default action"), style: .default, handler: { _ in
        NSLog("The \"OK\" alert occured.")
        }))
        self.present(alert, animated: true, completion: nil)
    }
    @objc private func logButtonTapped(_ sender: UIButton) {

        if let email = emailTextField.text,
           let password = passwordTextField.text {
            Auth.auth().signIn(withEmail: email, password: password) { [weak self] authResult, error in
                guard let self = self else { return }
                if let error = error {
                    print(error.localizedDescription)
                    if let error = error as NSError? {
                        if let authError = AuthErrorCode.Code(rawValue: error.code) {
                            switch authError {
                            case .invalidEmail:
                                self.showAlert("Email is invalid.")
                            case .operationNotAllowed:
                                self.showAlert("not allowed")
                            case .userDisabled:
                                self.showAlert("User's account is disabled.")
                            case .userNotFound:
                                self.showAlert("User's account was not found.")
                            case .wrongPassword:
                                self.showAlert("Wrong password. Try again")
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

extension LogInVC {
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
            
            logButton.topAnchor.constraint(equalTo: passwordTextField.bottomAnchor, constant: 10),
            logButton.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20),
            logButton.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20),

        ])
    }
}
