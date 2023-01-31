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

//    var backgroundEnterTime: String? {
//        get {
//            userDefault.value(forKey: Constants.UD.ENTER_BACKGROUND_TIME_KEY.rawValue) as? String
//        }
//    }
    
     func logOutUser() {
        coordinator.userLogin()
//        clearSavedBGTime()
    }
    
    //when user killed no longer need saved enter background time
//    private func clearSavedBGTime() {
//        userDefault.removeObject(forKey: Constants.UD.ENTER_BACKGROUND_TIME_KEY.rawValue)
//    }
    
    // check if user was in background more than desired time
//    private func shouldUserLogOut() {
//        if calculateTimeInBackground() > Int(Constants.DESIRED_TIME_KEEP_IN_BACKGROUND) {
//            logOutUser()
//        }
//    }
    
//    private func calculateTimeInBackground() -> Int {
//        guard let backgroundEnterTime = backgroundEnterTime else { return 0 }
//        let date = Date.getDate(dateString: backgroundEnterTime)
//        let component = Calendar.current.dateComponents([.minute, .second], from: date)
//        return component.second ?? 0
//    }
    
    //Confrim that user logged in or register succesfully
    func didUserInHome() {
        CoordinatorCacher.currentCoordinator = coordinator
        Application.shared.isUserFirstLaunch = true
//        shouldUserLogOut()
        Utils.wait(Constants.DESIRED_TIME_KEEP_IN_FORGROUND, {
//            logOutUser()
        })
    }
}

/// Use this type for parts that need current App coordinator
struct CoordinatorCacher {
   static var currentCoordinator: AppCoordinator?
}
