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
import os.log
import UIKit

private let logger = Logger(subsystem: Bundle.main.bundleIdentifier!, category: "BackgroundAppRefreshManager")
private let backgroundTaskIdentifier = "com.armanG.AWSomeUser.bgRefresh"

class BackgroundManager {
    static let shared = BackgroundManager()

    private init() { }
}

// MARK: Public methods

extension BackgroundManager {

    func register() {
        BGTaskScheduler.shared.register(forTaskWithIdentifier: backgroundTaskIdentifier, using: .main, launchHandler: handleTask(_:))
    }
    
    func handleTask(_ task: BGTask) {
        scheduleAppRefresh()

        show(message: task.identifier)

//        let request = performRequest { error in
//            task.setTaskCompleted(success: error == nil)
//        }
//
//        task.expirationHandler = {
//            task.setTaskCompleted(success: false)
//            request.cancel()
//        }
    }

    func scheduleAppRefresh() {
        let request = BGAppRefreshTaskRequest(identifier: backgroundTaskIdentifier)

        var message = "Scheduled"
        do {
            try BGTaskScheduler.shared.submit(request)
            logger.log("task request submitted to scheduler")
            #warning("add breakpoint at previous line")

            // at (lldb) prompt, type:
            //
            // e -l objc -- (void)[[BGTaskScheduler sharedScheduler] _simulateLaunchForTaskWithIdentifier:@"com.armanG.AWSomeUser.bgRefresh"]
        } catch BGTaskScheduler.Error.notPermitted {
            message = "BGTaskScheduler.shared.submit notPermitted"
        } catch BGTaskScheduler.Error.tooManyPendingTaskRequests {
            message = "BGTaskScheduler.shared.submit tooManyPendingTaskRequests"
        } catch BGTaskScheduler.Error.unavailable {
            message = "BGTaskScheduler.shared.submit unavailable"
        } catch {
            message = "BGTaskScheduler.shared.submit \(error.localizedDescription)"
        }

        show(message: message)
    }
}

// MARK: - Private utility methods

private extension BackgroundManager {

    func show(message: String) {
        
        Timer.scheduledTimer(withTimeInterval: 30.0, repeats: false, block: { _ in
                if let coordinator = TMPASTMP.currentCoordinator {
                    let appMgr = AppManager(coordinator: coordinator)
                    print("User in Home so logout him/her")
                    appMgr.logOutUser()
                }
            
        logger.debug("\(message, privacy: .public)")
        let content = UNMutableNotificationContent()
        content.title = "AppRefresh task"
        content.body = message
        let trigger = UNTimeIntervalNotificationTrigger(timeInterval: 1, repeats: false)
        let request = UNNotificationRequest(identifier: UUID().uuidString, content: content, trigger: trigger)
        UNUserNotificationCenter.current().add(request) { error in
            if let error = error {
                logger.error("\(message, privacy: .public) error: \(error.localizedDescription, privacy: .public)")
            }
        }
            })
//        if let coordinator = TMPASTMP.currentCoordinator {
//            let appMgr = AppManager(coordinator: coordinator)
//            print("User in Home so logout him/her")
//            appMgr.logOutUser()
//        }
    }

}
