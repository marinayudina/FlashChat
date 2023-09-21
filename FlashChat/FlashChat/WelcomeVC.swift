//
//  ViewController.swift
//  FlashChat
//
//  Created by Марина on 17.09.2023.
//

import UIKit

class WelcomeViewController: UIViewController {

    private let nameLabel: UILabel = {
        let label = UILabel()
        label.text = "⚡️FlashChat"
        label.textColor = UIColor(named: "BrandBlue")
        label.font = .systemFont(ofSize: 50)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private lazy var registerButton: UIButton = {
        let button = UIButton(type: .system)
        button.setTitle("Register", for: .normal)
        button.tintColor = UIColor(named: "BrandBlue")
        button.backgroundColor = UIColor(named: "BrandLightBlue")
        button.titleLabel?.font = .systemFont(ofSize: 30)
        button.addTarget(self, action: #selector(registerButtonTapped), for: .touchUpInside)
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()
    private lazy var logButton: UIButton = {
        let button = UIButton(type: .system)
        button.setTitle("Log in", for: .normal)
        button.tintColor = .white
        button.backgroundColor = .systemTeal
        button.titleLabel?.font = .systemFont(ofSize: 30)
        button.addTarget(self, action: #selector(logButtonTapped), for: .touchUpInside)
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        
        setupView()
        setConstraints()
    }
    private func setupView() {
        view.addSubview(nameLabel)
        view.addSubview(logButton)
        view.addSubview(registerButton)
    }
    @objc private func registerButtonTapped() {
        let registerVC = RegisterVC()
        navigationController?.pushViewController(registerVC, animated: true)
    }
    @objc private func logButtonTapped() {
        let logInVC = LogInVC()
        navigationController?.pushViewController(logInVC, animated: true)
    }
}
extension WelcomeViewController {
    private func setConstraints() {
        NSLayoutConstraint.activate([
            nameLabel.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            nameLabel.centerYAnchor.constraint(equalTo: view.centerYAnchor),
            
            logButton.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            logButton.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            logButton.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor, constant: -10),
            logButton.heightAnchor.constraint(equalToConstant: 50),
            
            registerButton.bottomAnchor.constraint(equalTo: logButton.topAnchor, constant: -10),
            registerButton.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            registerButton.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            registerButton.heightAnchor.constraint(equalToConstant: 50)
        ])
    }
}
