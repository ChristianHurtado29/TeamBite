//
//  LoginCustomCell.swift
//  TeamBite
//
//  Created by Christian Hurtado on 4/20/20.
//  Copyright © 2020 Christian Hurtado. All rights reserved.
//

enum UserType: String{
    case user
    case venueOwner
}

import UIKit

class LoginCustomCell: UITableViewCell {

    private let optionLabel: UILabel = {
       let label = UILabel()
        label.textAlignment = .center
        label.textColor = UIColor.blue
        label.font = UIFont(name: "Arial", size: 20)
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
        setUpOptionButtonConstraints()
    }
    
    private func setUpOptionButtonConstraints(){
        addSubview(optionLabel)
        optionLabel.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([optionLabel.centerYAnchor.constraint(equalTo: centerYAnchor), optionLabel.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 8), optionLabel.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -8)])
    }
    
    public func configureCell(_ option: String){
        optionLabel.text = option
    }
    
}
