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
        UNUserNotificationCenter.current().delegate = self

        BackgroundManager.shared.register()
        Application.shared.setup()
        return true
    }

    func applicationDidEnterBackground(_ application: UIApplication) {
        BackgroundManager.shared.scheduleAppRefresh()
        PersistentStorage.shared.saveContext()
    }
    
    func applicationWillEnterForeground(_ application: UIApplication) {
//        application.endBackgroundTask(UIBAC)
    }
}

extension AppDelegate: UNUserNotificationCenterDelegate {
    func userNotificationCenter(_ center: UNUserNotificationCenter, willPresent notification: UNNotification, withCompletionHandler completionHandler: @escaping (UNNotificationPresentationOptions) -> Void) {
        completionHandler([.list, .banner, .sound])
    }
}
