//
//  ChatVC.swift
//  FlashChat
//
//  Created by Марина on 17.09.2023.
//

import UIKit

class ChatVC: UIViewController {

    private let tableView: UITableView = {
        let tableView = UITableView()
        tableView.backgroundColor = .red
        tableView.translatesAutoresizingMaskIntoConstraints = false
//        tableView.register(<#T##nib: UINib?##UINib?#>, forCellReuseIdentifier: <#T##String#>)
        return tableView
    }()
    
    private lazy var sendButton: UIButton = {
        let button = UIButton(type: .system)
        button.translatesAutoresizingMaskIntoConstraints = false
        button.tintColor = .white
//        button.backgroundColor = .red
        button.contentMode = .scaleAspectFit
        button.setBackgroundImage(UIImage(systemName: "paperplane.fill"), for: .normal)
        return button
    }()
    
    private lazy var messageTextField: UITextField = {
        let textField = UITextField()
//        textField.placeholder = "  Write a message..."
        textField.attributedPlaceholder = NSAttributedString(
            string: "  Write a message...",
            attributes: [NSAttributedString.Key.foregroundColor: UIColor.black]
        )
        textField.font = .systemFont(ofSize: 15)
        textField.backgroundColor = .white
        textField.layer.cornerRadius = 10
        textField.textAlignment = .left
        textField.clipsToBounds = true
        textField.translatesAutoresizingMaskIntoConstraints = false
        return textField
    }()
    override func viewDidLoad() {
        super.viewDidLoad()

        view.backgroundColor = UIColor(named: "BrandPurple")
        
        setupView()
        setConstraints()
    }
    
    private func setupView() {
        view.addSubview(tableView)
        
        view.addSubview(messageTextField)
        view.addSubview(sendButton)
    }
    
}
extension ChatVC {
    private func setConstraints() {
        NSLayoutConstraint.activate([
            tableView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 20),
            tableView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            tableView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor, constant: -50),
            tableView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            
            messageTextField.topAnchor.constraint(equalTo: tableView.bottomAnchor, constant: 10),
            messageTextField.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 10),
            messageTextField.heightAnchor.constraint(equalTo: view.heightAnchor, multiplier: 0.04),
            
            sendButton.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -10),
            sendButton.leadingAnchor.constraint(equalTo: messageTextField.trailingAnchor, constant: 20),
            sendButton.topAnchor.constraint(equalTo: tableView.bottomAnchor, constant: 10),
            sendButton.heightAnchor.constraint(equalTo: view.heightAnchor, multiplier: 0.04),
            sendButton.widthAnchor.constraint(equalTo: view.widthAnchor, multiplier: 0.1),

            
            sendButton.centerYAnchor.constraint(equalTo: messageTextField.centerYAnchor)
            
        ])
 
    }
}
