//
//  UIViewController+SceneChange.swift
//  TeamBite
//
//  Created by Cameron Rivera on 4/22/20.
//  Copyright © 2020 Christian Hurtado. All rights reserved.
//

import UIKit

extension UIViewController {
    
    static func showTabController(storyboardName: String? = nil, viewControllerId: String? = nil, viewController: UIViewController? = nil){
        if let sb = storyboardName, let vcId = viewControllerId {
            let storyboard = UIStoryboard(name: sb, bundle: nil)
            let newVC = storyboard.instantiateViewController(identifier: vcId)
            resetWindow(newVC)
        } else if let vc = viewController{
            resetWindow(vc)
        }
    }
    
    static func resetWindow(_ vc: UIViewController) {
        guard let scene = UIApplication.shared.connectedScenes.first, let sceneDelegate = scene.delegate as? SceneDelegate, let window = sceneDelegate.window else {
            fatalError("Could not reset window")
        }
        
        window.rootViewController = UINavigationController(rootViewController: vc)
    }
}
