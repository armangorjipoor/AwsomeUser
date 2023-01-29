//
//  AppDelegate.swift
//  AwsomeUser
//
//  Created by Arman Gorj on 11/6/1401 AP.
//

import UIKit

@main
class AppDelegate: UIResponder, UIApplicationDelegate {

    private var coordinator: AppCoordinator?
    var window: UIWindow?
    
    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        window = UIWindow()
//        if let window = window {
//            self.coordinator = AppCoordinator(window: window)
//        }
//        self.coordinator?.startApp()
        
        Application.shared.setup()
        return true
    }

    func applicationDidEnterBackground(_ application: UIApplication) {
        
        Application.shared.saveUserEnterBackgroundTime()
        PersistentStorage.shared.saveContext()
    }
    
    func applicationWillEnterForeground(_ application: UIApplication) {
        print("F")
    }
}

