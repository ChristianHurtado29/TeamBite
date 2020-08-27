//
//  ResourcesView.swift
//  TeamBite
//
//  Created by Christian Hurtado on 8/25/20.
//  Copyright © 2020 Christian Hurtado. All rights reserved.
//

import UIKit

class ResourcesView: UIView {
    
    public lazy var tableView: UITableView = {
        let tableView = UITableView()
        tableView.register(ResourcesCell.self, forCellReuseIdentifier: "resourcesCell")
        return tableView
    }()
    
    override init(frame: CGRect){
        super.init(frame: UIScreen.main.bounds)
        commonInit()
    }
    
    required init?(coder: NSCoder){
        super.init(coder: coder)
        commonInit()
    }
    
    private func commonInit(){
        addSubview(tableView)
        tableView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            tableView.topAnchor.constraint(equalTo: safeAreaLayoutGuide.topAnchor, constant: 20),
            tableView.leadingAnchor.constraint(equalTo: safeAreaLayoutGuide.leadingAnchor, constant: 8),
            tableView.trailingAnchor.constraint(equalTo: safeAreaLayoutGuide.trailingAnchor,  constant: -8),
            tableView.bottomAnchor.constraint(equalTo: safeAreaLayoutGuide.bottomAnchor)
        ])
    }
    
}
