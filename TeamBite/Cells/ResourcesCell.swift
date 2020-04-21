//
//  ResourcesCell.swift
//  TeamBite
//
//  Created by Christian Hurtado on 4/21/20.
//  Copyright © 2020 Christian Hurtado. All rights reserved.
//

import UIKit

class ResourcesCell: UITableViewCell {

    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var contactLabel: UILabel!
    @IBOutlet weak var phoneLabel: UILabel!
    @IBOutlet weak var linkLabel: UILabel!
    
    
    func configureCell(for resource: Resources){
        nameLabel.text = resource.name
        contactLabel.text = resource.contactPerson
        phoneLabel.text = resource.phone
        linkLabel.text = resource.link
    }

}
