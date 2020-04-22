//
//  ResourcesViewController.swift
//  TeamBite
//
//  Created by Christian Hurtado on 4/20/20.
//  Copyright © 2020 Christian Hurtado. All rights reserved.
//

import UIKit

class ResourcesViewController: UIViewController {

    @IBOutlet weak var tableView: UITableView!
    
    var resources = [Resources](){
        didSet{
            tableView.reloadData()
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.dataSource = self
        tableView.delegate = self
        loadResources()
    }
    
    func loadResources(){
        resources = Resources.allResources
    }
}

extension ResourcesViewController: UITableViewDataSource{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return resources.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "resourcesCell", for: indexPath) as? ResourcesCell else {
            fatalError("could not dequeue to resource cell")
        }
        let selResource = resources[indexPath.row]
        cell.configureCell(for: selResource)
        return cell
    }
    
    
}
extension ResourcesViewController: UITableViewDelegate{
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 250
    }
}
