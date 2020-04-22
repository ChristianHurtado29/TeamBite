//
//  UIViewController+SceneChange.swift
//  TeamBite
//
//  Created by Cameron Rivera on 4/22/20.
//  Copyright © 2020 Christian Hurtado. All rights reserved.
//

import UIKit

extension UIViewController {
    
    static func resetWindow(_ vc: UIViewController) {
        guard let scene = UIApplication.shared.connectedScenes.first, let sceneDelegate = scene.delegate as? SceneDelegate, let window = sceneDelegate.window else {
            fatalError("Could not reset window")
        }
        
        window.rootViewController = UINavigationController(rootViewController: vc)
    }
}
