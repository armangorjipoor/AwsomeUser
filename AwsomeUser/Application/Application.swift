//
//  AppManager.swift
//  AwsomeUser
//
//  Created by Arman Gorj on 11/7/1401 AP.
//

import Foundation
import UIKit

enum AppRoute {
    case login
    case register
//    case homeScreen
//    case none
}

class Application {
    
    private init(){}
    private let userDefault = UserDefaults.standard
    
    var coordinator: AppCoordinator?
    
    static let shared = Application()
    
    func setup() {
        let appDelegate = (UIApplication.shared.delegate) as! AppDelegate
        determineAppRoute(with: appDelegate.window!)
    }
    var isIUserInHomeScreen: Bool?
    
    var isUserFirstLaunch: Bool? {
        get {
            if userDefault.value(forKey: Constants.UD.FIRST_APP_LAUNCH.rawValue) != nil{
                return true
            } else {
                return nil
            }
        }
        set {
            userDefault.set(newValue, forKey: Constants.UD.FIRST_APP_LAUNCH.rawValue)
        }
    }
    
    private func determineAppRoute(with window: UIWindow) {
            coordinator = AppCoordinator(window: window, appRoute: .register)
    }
    
    // save the time that user enter background
    func saveUserEnterBackgroundTime() {
        if isIUserInHomeScreen != nil {
            userDefault.set(Date.currentDate, forKey: Constants.UD.ENTER_BACKGROUND_TIME_KEY.rawValue)
        }
    }
}
