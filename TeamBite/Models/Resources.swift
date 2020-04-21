//
//  Resources.swift
//  TeamBite
//
//  Created by Christian Hurtado on 4/21/20.
//  Copyright © 2020 Christian Hurtado. All rights reserved.
//

import Foundation

struct Resources {
    let name: String
    let contactPerson: String?
    let phone: String?
    let link: String?
    
    static let allResources: [Resources] = [
        Resources(name: "The Door",
                  contactPerson: "Hilda Mulero",
                  phone: "(212) 941-9090",
                  link: "https://door.org"),
        Resources(name: "The Dream",
                  contactPerson: "Gaby Pacheco",
                  phone: "(855) 670-4787",
                  link: "https://www.thedream.us"),
        Resources(name: "National Latinx Psychological Association",
                  contactPerson: "",
                  phone: "",
                  link: "https://www.nlpa.ws/"),
        Resources(name: "Cheryl David Law",
                  contactPerson: "Cheryl David",
                  phone: "(646) 681-4252",
                  link: "https://www.cheryldavidlaw.com/")
    ]
}
