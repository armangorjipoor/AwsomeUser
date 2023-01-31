//
//  BackgroundManager.swift
//  AwsomeUser
//
//  Created by Arman Gorj on 11/10/1401 AP.
//

import Foundation
import Foundation
import UserNotifications
import BackgroundTasks
import UIKit


private let backgroundTaskIdentifier = Constants.BG_TASK_IDENTIFIER

class BackgroundManager {
    static let shared = BackgroundManager()

    private init() { }
}

// MARK: Public methods

extension BackgroundManager {

    /*
     /// Tips: for try in simulator add follow command
     // e -l objc -- (void)[[BGTaskScheduler sharedScheduler] _simulateLaunchForTaskWithIdentifier:@"com.armanG.AWSomeUser.bgRefresh"]
     */
    
    func register() {
        BGTaskScheduler.shared.register(forTaskWithIdentifier: backgroundTaskIdentifier, using: .main, launchHandler: handleTask(_:))
    }
    
    func handleTask(_ task: BGTask) {
        scheduleAppRefresh()
        show(message: "You have logged Out")
    }

    func scheduleAppRefresh() {
        let request = BGAppRefreshTaskRequest(identifier: backgroundTaskIdentifier)

        var message = "You have logged out"
        do {
            try BGTaskScheduler.shared.submit(request)
            bglogger.log("task request submitted to scheduler")
            
        } catch BGTaskScheduler.Error.notPermitted {
            bglogger.log("AWsomeUser.shared.submit notPermitted")
        } catch BGTaskScheduler.Error.tooManyPendingTaskRequests {
            bglogger.log("AWsomeUser.shared.submit tooManyPendingTaskRequests")
        } catch BGTaskScheduler.Error.unavailable {
            bglogger.log("AWsomeUser.shared.submit unavailable")
        } catch {
            bglogger.log("AWsomeUser.shared.submit \(error.localizedDescription)")
        }

        show(message: message)
    }
}

// MARK: - Private utility methods

private extension BackgroundManager {

    func show(message: String) {
        
        Timer.scheduledTimer(withTimeInterval: 30.0, repeats: false, block: { _ in
                if let coordinator = CoordinatorCacher.currentCoordinator {
                    let appMgr = AppManager(coordinator: coordinator)
                    print("User in Home so logout him/her")
                    appMgr.logOutUser()
                }
            
            bglogger.debug("\(message, privacy: .public)")
        let content = UNMutableNotificationContent()
        content.title = "Loguot Alert"
        content.body = message
        let trigger = UNTimeIntervalNotificationTrigger(timeInterval: 1, repeats: false)
        let request = UNNotificationRequest(identifier: UUID().uuidString, content: content, trigger: trigger)
        UNUserNotificationCenter.current().add(request) { error in
            if let error = error {
                bglogger.error("\(message, privacy: .public) error: \(error.localizedDescription, privacy: .public)")
            }
        }
            })
    }

}
