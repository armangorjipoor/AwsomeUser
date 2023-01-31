//
//  AppManager.swift
//  AwsomeUser
//
//  Created by Arman Gorj on 11/9/1401 AP.
//

import Foundation

struct AppManager {
    
    var coordinator: AppCoordinator
    private let userDefault = UserDefaults.standard
    
     func logOutUser() {
        coordinator.userLogin()
    }

    
    //Confrim that user logged in or register succesfully
    func didUserInHome() {
        CoordinatorCacher.currentCoordinator = coordinator
        Application.shared.isUserFirstLaunch = true
        Utils.wait(Constants.DESIRED_TIME_KEEP_IN_FORGROUND, {
            logOutUser()
        })
    }
}

/// Use this type for parts that need current App coordinator
struct CoordinatorCacher {
   static var currentCoordinator: AppCoordinator?
}
