//
//  SceneDelegate.swift
//  TeamBite
//
//  Created by Christian Hurtado on 4/20/20.
//  Copyright © 2020 Christian Hurtado. All rights reserved.
//

import UIKit
import FirebaseAuth

class SceneDelegate: UIResponder, UIWindowSceneDelegate {
    
    var window: UIWindow?
    
    
    func scene(_ scene: UIScene, willConnectTo session: UISceneSession, options connectionOptions: UIScene.ConnectionOptions) {
        // Use this method to optionally configure and attach the UIWindow `window` to the provided UIWindowScene `scene`.
        // If using a storyboard, the `window` property will automatically be initialized and attached to the scene.
        // This delegate does not imply the connecting scene or session are new (see `application:configurationForConnectingSceneSession` instead).
        guard let windowScene = (scene as? UIWindowScene) else { return }
        
        window = UIWindow(frame: UIScreen.main.bounds)
        window?.windowScene = windowScene
//        do {
//            try Auth.auth().signOut()
//        } catch {
//            print(error.localizedDescription)
//        }
//        if let _ = Auth.auth().currentUser?.email {
//            let storyboard = UIStoryboard(name: "Venues", bundle: nil)
//            guard let venueTabController = storyboard.instantiateViewController(identifier: "VenueStoryboard") as? UITabBarController else {
//                fatalError("Could not create instance of TabBarController.")
//            }
//            window?.rootViewController = venueTabController
//        } else if let _ = Auth.auth().currentUser?.phoneNumber {
//        let tabBarController = TabBarController()
//
//            window?.rootViewController = tabBarController
//
//        } else {
//            window?.rootViewController = UINavigationController(rootViewController: TabBarController())
//        let storyboard = UIStoryboard(name: "Venues", bundle: nil)
//        let vc = storyboard.instantiateViewController(identifier: "VenueStoryboard") as? VenueViewController ?? MainViewController()
        UserDefaultsHandler.resetState()
        let vc = MainViewController(AppState(rawValue: UserDefaultsHandler.getAppState() ?? "unclaimed") ?? AppState.offerUnclaimed)
//        let vc = LoginViewController()
        window?.rootViewController = UINavigationController(rootViewController: vc)
//        UIViewController.showTabController(storyboardName: "Venues", viewControllerId: "VenueStoryboard", viewController: nil)
////        }
        window?.makeKeyAndVisible()
    }
    
    func sceneDidDisconnect(_ scene: UIScene) {
        // Called as the scene is being released by the system.
        // This occurs shortly after the scene enters the background, or when its session is discarded.
        // Release any resources associated with this scene that can be re-created the next time the scene connects.
        // The scene may re-connect later, as its session was not neccessarily discarded (see `application:didDiscardSceneSessions` instead).
    }
    
    func sceneDidBecomeActive(_ scene: UIScene) {
        // Called when the scene has moved from an inactive state to an active state.
        // Use this method to restart any tasks that were paused (or not yet started) when the scene was inactive.
    }
    
    func sceneWillResignActive(_ scene: UIScene) {
        // Called when the scene will move from an active state to an inactive state.
        // This may occur due to temporary interruptions (ex. an incoming phone call).
    }
    
    func sceneWillEnterForeground(_ scene: UIScene) {
        // Called as the scene transitions from the background to the foreground.
        // Use this method to undo the changes made on entering the background.
    }
    
    func sceneDidEnterBackground(_ scene: UIScene) {
        // Called as the scene transitions from the foreground to the background.
        // Use this method to save data, release shared resources, and store enough scene-specific state information
        // to restore the scene back to its current state.
    }
    
    
}

