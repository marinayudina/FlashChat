//
//  LogInVC.swift
//  FlashChat
//
//  Created by Марина on 17.09.2023.
//

import UIKit

class LogInVC: UIViewController {

//    private let emailView: UIView = {
//        let view = UIView()
//        view.translatesAutoresizingMaskIntoConstraints = false
//        return view
//    }()
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
//    private let emailView: UIImageView = {
//        let imageView = UIImageView(image: UIImage(named: "textfield"))
//        imageView.backgroundColor = .black
//        imageView.contentMode = .scaleAspectFill
//        imageView.clipsToBounds = true
//        imageView.translatesAutoresizingMaskIntoConstraints = false
//        return imageView
//    }()
    
    private lazy var passwordTextField: UITextField = {
        let textField = UITextField()
        textField.placeholder = "Password"
        textField.font = .systemFont(ofSize: 25)
        textField.backgroundColor = .white
        textField.layer.cornerRadius = 10
        textField.textAlignment = .center
        textField.clipsToBounds = true
        textField.translatesAutoresizingMaskIntoConstraints = false
        return textField
    }()
    
//    private let passwordView: UIImageView = {
//        let imageView = UIImageView(image: UIImage(named: "textfield"))
////        imageView.contentMode = .scaleAspectFill
//        imageView.backgroundColor = .black
//        imageView.translatesAutoresizingMaskIntoConstraints = false
//        return imageView
//    }()
    
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
    }
    private func   setupView() {
        view.addSubview(emailTextField)
        
        view.addSubview(passwordTextField)
        view.addSubview(logButton)
    }
    
    @objc private func logButtonTapped(_ sender: UIButton) {
        let chatVC = ChatVC()
        navigationController?.pushViewController(chatVC, animated: true)
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
