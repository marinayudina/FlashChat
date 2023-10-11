//
//  ChatVC.swift
//  FlashChat
//
//  Created by Марина on 17.09.2023.
//

import UIKit
import Firebase

class ChatVC: UIViewController {

    let db = Firestore.firestore()
    
    var messages: [Message] = []
    
    private lazy var chatTableView: UITableView = {
        let tableView = UITableView(frame: .zero, style: .plain)
        tableView.translatesAutoresizingMaskIntoConstraints = false
        tableView.dataSource = self
        tableView.delegate = self
        tableView.register(chatTableViewCell.self, forCellReuseIdentifier: chatTableViewCell.idChatTableViewCell
        )
        tableView.separatorStyle = .none
        return tableView
    }()
    
    private lazy var sendButton: UIButton = {
        let button = UIButton(type: .custom)
        button.translatesAutoresizingMaskIntoConstraints = false
        button.tintColor = .white
//        button.backgroundColor = .red
//        button.contentMode = .scaleAspectFit
        button.addTarget(self, action: #selector(sendButtonPressed), for: .touchUpInside)
//        button.setBackgroundImage(UIImage(systemName: "paperplane.fill"), for: .normal)
        let imageP = UIImage(systemName: "paperplane.fill")
        button.setImage(imageP, for: .normal)
        return button
    }()
    
    private lazy var messageTextField: UITextField = {
        let textField = UITextField()
        textField.attributedPlaceholder = NSAttributedString(
            string: "  Write a message...",
            attributes: [NSAttributedString.Key.foregroundColor: UIColor.black]
        )
        textField.font = .systemFont(ofSize: 15)
        textField.backgroundColor = .white
        textField.layer.cornerRadius = 10
        textField.textAlignment = .left
        textField.clipsToBounds = true
        textField.leftView = UIView(frame: CGRect(x: 0, y: 0, width: 10, height: textField.frame.height))
        textField.leftViewMode = .always
        textField.translatesAutoresizingMaskIntoConstraints = false
        return textField
    }()
    
    private lazy var logOutButton: UIBarButtonItem = {
        let button = UIBarButtonItem()
        button.style = .plain
        button.title = "Log Out"
        button.target = self
        button.action = #selector(logOutPressed)
        return button
    }()
    
    override func viewWillAppear(_ animated: Bool) {
        navigationController?.navigationBar.backgroundColor = UIColor(named: "BrandPurple")
//        navigationController?.navigationBar.barTintColor = UIColor(named: "BrandBlue")
        navigationController?.navigationBar.isTranslucent = true
    }
    override func viewDidLoad() {
        super.viewDidLoad()

        view.backgroundColor = UIColor(named: "BrandPurple")
//        navigationController?.navigationBar.backgroundColor = UIColor(named: "BrandBlue")


        
        setupView()
        setConstraints()
        loadMessages()
        
        sendButton.imageView?.contentMode = .scaleAspectFit
    }
    
    private func setupView() {
        view.addSubview(chatTableView)
        
        view.addSubview(messageTextField)
        view.addSubview(sendButton)
        

        self.navigationItem.rightBarButtonItem  = logOutButton
        self.navigationItem.hidesBackButton = true
        self.title = "⚡️FlashChat"
        
        
    }
    
    func loadMessages() {
        
        db.collection(FStore.collectionName)
            .order(by: FStore.dateField)
            .addSnapshotListener { (querySnapshot, error) in
            self.messages = []
            
            if let error = error {
                print("error with Data get")
            } else {
                if let snapshotDoc = querySnapshot?.documents {
                    for doc in snapshotDoc {
                        let data = doc.data()
                        if let messageSender = data[FStore.senderField] as? String,
                           let messageBody = data[FStore.bodyField] as? String {
                                let newMessage = Message(sender: messageSender, body: messageBody)
                                self.messages.append(newMessage)
                            
                            DispatchQueue.main.async {
                                self.chatTableView.reloadData()
                                
                                let indexPath = IndexPath(row: self.messages.count - 1, section: 0)
                                self.chatTableView.scrollToRow(at: indexPath, at: .top, animated: true)
                            }
                        }
                        
                    }
                }
            }
        }
    }
    
    @objc private func sendButtonPressed(_ sender: UIButton) {
        if let messageBody = messageTextField.text,
           let messageSender = Auth.auth().currentUser?.email {
            db.collection(FStore.collectionName).addDocument(
                data: [FStore.senderField : messageSender,
                       FStore.bodyField : messageBody,
                       FStore.dateField: Date().timeIntervalSince1970
            ]){ error in
                    if let error = error {
                        print("error with saving data")
                    } else {
                        print("Siccessfully saved data")
                        DispatchQueue.main.async {
                            self.messageTextField.text = ""

                        }
                    }
                }
        }
        
    }
    
    @objc private func logOutPressed(_ sender: UIBarButtonItem) {
        print("log out")
        do {
            try Auth.auth().signOut()
            navigationController?.popToRootViewController(animated: true)
        } catch let signOutError as NSError {
          print("Error signing out: %@", signOutError)
        }
    }
    
}
extension ChatVC {
    private func setConstraints() {
        NSLayoutConstraint.activate([
            chatTableView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            chatTableView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            chatTableView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor, constant: -35),
            chatTableView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            
            messageTextField.topAnchor.constraint(equalTo: chatTableView.bottomAnchor, constant: 10),
            messageTextField.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 10),
            messageTextField.heightAnchor.constraint(equalTo: view.heightAnchor, multiplier: 0.04),
            
            sendButton.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -10),
            sendButton.leadingAnchor.constraint(equalTo: messageTextField.trailingAnchor, constant: 20),
            sendButton.topAnchor.constraint(equalTo: chatTableView.bottomAnchor, constant: 10),
            sendButton.heightAnchor.constraint(equalTo: view.heightAnchor, multiplier: 0.04),
            sendButton.widthAnchor.constraint(equalTo: view.widthAnchor, multiplier: 0.1),

            
            sendButton.centerYAnchor.constraint(equalTo: messageTextField.centerYAnchor)
            
        ])
 
    }
}

extension ChatVC: UITableViewDelegate{
//    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
//        return 40
//    }
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        print(indexPath)
    }
}

//MARK: UITableViewDataSource
extension ChatVC: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return messages.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let message = messages[indexPath.row]
        
        guard let cell = tableView.dequeueReusableCell(withIdentifier: chatTableViewCell.idChatTableViewCell, for: indexPath) as? chatTableViewCell else { return UITableViewCell() }
        
        cell.messageLabel.text = messages[indexPath.row].body
        
        //message from a current user
        if message.sender == Auth.auth().currentUser?.email {
            cell.YouImage.isHidden = true
            cell.MeImage.isHidden = false
            cell.purpleView.backgroundColor = UIColor(named: "BrandLightPurple")
            cell.messageLabel.textColor = UIColor(named: "BrandPurple")
        } else {
            cell.YouImage.isHidden = false
            cell.MeImage.isHidden = true
            cell.purpleView.backgroundColor = UIColor(named: "BrandPurple")
            cell.messageLabel.textColor = UIColor(named: "BrandLightPurple")
        }
            

        return cell
    }
    
    
}
