//
//  ResourcesCell.swift
//  TeamBite
//
//  Created by Christian Hurtado on 4/21/20.
//  Copyright © 2020 Christian Hurtado. All rights reserved.
//

import UIKit

class ResourcesCell: UITableViewCell {

//    @IBOutlet weak var nameLabel: UILabel!
//    @IBOutlet weak var contactLabel: UILabel!
//    @IBOutlet weak var phoneLabel: UILabel!
//    @IBOutlet weak var linkLabel: UILabel!
    
    private lazy var nameLabel: UILabel = {
        let label = UILabel()
        label.textAlignment = .center
        label.numberOfLines = 0
        label.font = UIFont.preferredFont(forTextStyle: .largeTitle)
        return label
    }()
    
    private lazy var contactLabel: UILabel = {
        let label = UILabel()
        label.textAlignment = .center
        label.font = UIFont.preferredFont(forTextStyle: .subheadline)
        return label
    }()
    
    private lazy var phoneLabel: UILabel = {
        let label = UILabel()
        label.textAlignment = .center
        label.font = UIFont.preferredFont(forTextStyle: .body)
        return label
    }()
    
    private lazy var linkLabel: UILabel = {
        let label = UILabel()
        label.textAlignment = .center
        label.font = UIFont.preferredFont(forTextStyle: .body)
        return label
    }()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        commonInit()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        commonInit()
    }
    
    private func commonInit(){
        setUpName()
        setUpContact()
        setUpPhone()
        setUpLink()
    }
    
    private func setUpName(){
        addSubview(nameLabel)
        nameLabel.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            nameLabel.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 8),
            nameLabel.leadingAnchor.constraint(equalTo: safeAreaLayoutGuide.leadingAnchor, constant: 20),
            nameLabel.trailingAnchor.constraint(equalTo: safeAreaLayoutGuide.trailingAnchor, constant: -20)
        ])
    }
    
    private func setUpContact(){
        addSubview(contactLabel)
        contactLabel.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            contactLabel.topAnchor.constraint(equalTo: nameLabel.bottomAnchor, constant: 8),
            contactLabel.leadingAnchor.constraint(equalTo: nameLabel.leadingAnchor),
            contactLabel.trailingAnchor.constraint(equalTo: nameLabel.trailingAnchor)
        ])
    }
    
    private func setUpPhone(){
        addSubview(phoneLabel)
        phoneLabel.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            phoneLabel.topAnchor.constraint(equalTo: contactLabel.bottomAnchor, constant: 8),
            phoneLabel.leadingAnchor.constraint(equalTo: contactLabel.leadingAnchor),
            phoneLabel.trailingAnchor.constraint(equalTo: contactLabel.trailingAnchor)
        ])
    }
    
    private func setUpLink(){
        addSubview(linkLabel)
        linkLabel.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            linkLabel.topAnchor.constraint(equalTo: phoneLabel.bottomAnchor, constant: 8),
            linkLabel.leadingAnchor.constraint(equalTo: phoneLabel.leadingAnchor),
            linkLabel.trailingAnchor.constraint(equalTo: phoneLabel.trailingAnchor)
        ])
    }
    
    func configureCell(for resource: Resources){
        nameLabel.text = resource.name
        contactLabel.text = resource.contactPerson
        phoneLabel.text = resource.phone
        linkLabel.text = resource.link
    }

}
