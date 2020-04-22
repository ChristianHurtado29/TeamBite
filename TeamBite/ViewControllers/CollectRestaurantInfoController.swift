//
//  CollectRestaurantInfoController.swift
//  TeamBite
//
//  Created by Cameron Rivera on 4/21/20.
//  Copyright © 2020 Christian Hurtado. All rights reserved.
//

import UIKit

class CollectRestaurantInfoController: UIViewController {

    private let collectVenueInfoView = CollectVenueInfoView()
    
    override func loadView(){
        view = collectVenueInfoView
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setUp()
    }
    
    private func setUp(){
        collectVenueInfoView.backgroundColor = UIColor.systemBackground
    }

}
