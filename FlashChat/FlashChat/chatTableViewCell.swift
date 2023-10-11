//
//  chatTableViewCell.swift
//  FlashChat
//
//  Created by Марина on 06.10.2023.
//

import UIKit

class chatTableViewCell: UITableViewCell {

    static let idChatTableViewCell = "idChatTableViewCell"
     let messageLabel: UILabel = {
        let label = UILabel()
        label.text = "Text"
        label.textColor = UIColor(named: "BrandLightPurple")
         label.numberOfLines = 0
//         label.adjustsFontSizeToFitWidth = true
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    let purpleView: UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.backgroundColor = UIColor(named: "BrandPurple")
        view.layer.cornerRadius = 15
        return view
    }()
     let MeImage: UIImageView = {
        let imageV = UIImageView(image: UIImage(named: "MeAvatar"))
        imageV.translatesAutoresizingMaskIntoConstraints = false
        imageV.contentMode = .scaleAspectFit
        return imageV
    }()
    let YouImage: UIImageView = {
       let imageV = UIImageView(image: UIImage(named: "YouAvatar"))
       imageV.translatesAutoresizingMaskIntoConstraints = false
       imageV.contentMode = .scaleAspectFit
       return imageV
   }()
    lazy var mainStack: UIStackView = {
        let stackView = UIStackView()
        stackView.axis = .horizontal
        stackView.distribution = .fill
        stackView.spacing = 20
        stackView.translatesAutoresizingMaskIntoConstraints = false
        return stackView
    }()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        backgroundColor = .clear
        selectionStyle = .none
        
        mainStack.addArrangedSubview(YouImage)
        mainStack.addArrangedSubview(purpleView)
        mainStack.addArrangedSubview(MeImage)
        addSubview(mainStack)
        purpleView.addSubview(messageLabel)
        
        addConstraints([MeImage.heightAnchor.constraint(equalToConstant: 40),
                        MeImage.widthAnchor.constraint(equalToConstant: 40),
                        
                        YouImage.heightAnchor.constraint(equalToConstant: 40),
                        YouImage.widthAnchor.constraint(equalToConstant: 40),
                        
                        mainStack.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 10),
                        mainStack.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -10),
                        mainStack.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -10),
                        mainStack.topAnchor.constraint(equalTo: topAnchor, constant: 10),

                        messageLabel.leadingAnchor.constraint(equalTo: purpleView.leadingAnchor, constant: 10),
                        messageLabel.trailingAnchor.constraint(equalTo: purpleView.trailingAnchor, constant: -10),
                        messageLabel.centerYAnchor.constraint(equalTo: purpleView.centerYAnchor)
//                        messageLabel.bottomAnchor.constraint(equalTo: purpleView.bottomAnchor, constant: -10),
//                        messageLabel.topAnchor.constraint(equalTo: purpleView.topAnchor, constant: 10)
                       ])
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}
