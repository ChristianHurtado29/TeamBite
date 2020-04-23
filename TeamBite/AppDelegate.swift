//
//  AppDelegate.swift
//  TeamBite
//
//  Created by Christian Hurtado on 4/20/20.
//  Copyright © 2020 Christian Hurtado. All rights reserved.
//

import UIKit
import AVKit
import Firebase

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {


    var audioPlayer = AVAudioPlayer()
    
        func playSound(file:String, ext:String) -> Void {
            do {
                let sound = Bundle.main.path(forResource: "Bite2", ofType: "mp3")
                audioPlayer = try AVAudioPlayer(contentsOf: URL(fileURLWithPath: sound!))
                audioPlayer.prepareToPlay()
                audioPlayer.currentTime = 0
                audioPlayer.play()
            } catch {
                fatalError()
    }
    }

    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        // Override point for customization after application launch.
        UINavigationBar.appearance().backgroundColor = #colorLiteral(red: 0.8549019694, green: 0.250980407, blue: 0.4784313738, alpha: 1)
        UITabBar.appearance().tintColor = #colorLiteral(red: 0.8549019694, green: 0.250980407, blue: 0.4784313738, alpha: 1)
        
        playSound(file: "Bite2", ext: "mp3")
        FirebaseApp.configure()
        return true
    }

    // MARK: UISceneSession Lifecycle

    func application(_ application: UIApplication, configurationForConnecting connectingSceneSession: UISceneSession, options: UIScene.ConnectionOptions) -> UISceneConfiguration {
        // Called when a new scene session is being created.
        // Use this method to select a configuration to create the new scene with.
        return UISceneConfiguration(name: "Default Configuration", sessionRole: connectingSceneSession.role)
    }

    func application(_ application: UIApplication, didDiscardSceneSessions sceneSessions: Set<UISceneSession>) {
        // Called when the user discards a scene session.
        // If any sessions were discarded while the application was not running, this will be called shortly after application:didFinishLaunchingWithOptions.
        // Use this method to release any resources that were specific to the discarded scenes, as they will not return.
    }


}

