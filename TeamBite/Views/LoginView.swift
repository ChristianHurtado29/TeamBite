//
//  LoginView.swift
//  TeamBite
//
//  Created by Cameron Rivera on 4/21/20.
//  Copyright © 2020 Christian Hurtado. All rights reserved.
//

import UIKit

class LoginView: UIView {
    
    public lazy var loginTableView: UITableView = {
       let tableView = UITableView()
        return tableView
    }()
    
    public lazy var directionsLabel: UILabel = {
       let label = UILabel()
        label.textColor = UIColor.black
        label.textAlignment = .center
        label.text = "Are you a venue owner, or are you hungry?"
        label.font = UIFont(name: "Arial", size: 20)
        label.numberOfLines = 2
        return label
    }()
    
    override init(frame: CGRect){
        super.init(frame: UIScreen.main.bounds)
        commonInit()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        commonInit()
    }
    
    private func commonInit(){
        setUpDirectionsLabelConstraints()
        setUpLoginTableViewConstraints()
    }
    
    private func setUpDirectionsLabelConstraints(){
        addSubview(directionsLabel)
        directionsLabel.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([directionsLabel.topAnchor.constraint(equalTo: safeAreaLayoutGuide.topAnchor, constant: 100), directionsLabel.leadingAnchor.constraint(equalTo: safeAreaLayoutGuide.leadingAnchor, constant: 8), directionsLabel.trailingAnchor.constraint(equalTo: safeAreaLayoutGuide.trailingAnchor, constant: -8)])
    }
    
    private func setUpLoginTableViewConstraints(){
        addSubview(loginTableView)
        loginTableView.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([loginTableView.centerXAnchor.constraint(equalTo: centerXAnchor), loginTableView.centerYAnchor.constraint(equalTo: centerYAnchor), loginTableView.heightAnchor.constraint(equalTo: heightAnchor, multiplier: 0.3), loginTableView.widthAnchor.constraint(equalTo: widthAnchor, multiplier: 0.9)])
    }
    
}
