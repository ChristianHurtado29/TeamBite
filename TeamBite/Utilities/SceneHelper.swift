//
//  SceneRetriever.swift
//  TeamBite
//
//  Created by Cameron Rivera on 9/19/20.
//  Copyright © 2020 Christian Hurtado. All rights reserved.
//

import UIKit

struct SceneHelper {
    static var window: UIWindow? {
        guard let scene = UIApplication.shared.connectedScenes.first, let sceneDelegate = scene.delegate as? SceneDelegate, let window = sceneDelegate.window else {
            return nil
        }
        return window
    }
}
