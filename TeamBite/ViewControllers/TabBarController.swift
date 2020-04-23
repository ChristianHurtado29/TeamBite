//
//  TabBarController.swift
//  TeamBite
//
//  Created by David Lin on 4/23/20.
//  Copyright © 2020 Christian Hurtado. All rights reserved.
//

import UIKit

class TabBarController: UITabBarController {
    
    public lazy var mainVC: MainViewController = {
        let vc = MainViewController()
        return vc
    }()
    
    
    public lazy var resourcesVC: ResourcesViewController = {
        let mainSB = UIStoryboard(name: "Wireframe", bundle: nil)
        guard let resourcesVC = mainSB.instantiateViewController(identifier: "ResourcesViewController") as? ResourcesViewController else {fatalError()}
        return resourcesVC
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        viewControllers = [mainVC, UINavigationController(rootViewController: resourcesVC)]
    }
    
    
    
    
}
