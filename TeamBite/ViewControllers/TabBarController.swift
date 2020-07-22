//
//  TabBarController.swift
//  TeamBite
//
//  Created by David Lin on 4/23/20.
//  Copyright © 2020 Christian Hurtado. All rights reserved.
//

import UIKit

class TabBarController: UITabBarController {
    
    private lazy var mainVC: MainViewController = {
        let vc = MainViewController()
        vc.tabBarItem = UITabBarItem(title: "Explore", image: UIImage(systemName: "globe"), tag: 0)
        return vc
    }()
    
    
    private lazy var resourcesVC: ResourcesViewController = {
        let mainSB = UIStoryboard(name: "Wireframe", bundle: nil)
        guard let resourcesVC = mainSB.instantiateViewController(identifier: "ResourcesViewController") as? ResourcesViewController else {fatalError()}
        resourcesVC.tabBarItem = UITabBarItem(title: "Resources", image: UIImage(systemName: "folder"), tag: 1)
        return resourcesVC
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        viewControllers = [UINavigationController(rootViewController: mainVC), UINavigationController(rootViewController: resourcesVC)]
    }
    
    
    
    
}
