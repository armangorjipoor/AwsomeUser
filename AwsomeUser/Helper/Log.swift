//
//  Log.swift
//  AwsomeUser
//
//  Created by Arman Gorj on 11/11/1401 AP.
//

import Foundation
import os.log

let loggerVC = Logger(subsystem: Bundle.main.bundleIdentifier!, category: "ViewController")
 let bglogger = Logger(subsystem: Bundle.main.bundleIdentifier!, category: "BackgroundAppRefreshManager")
let notifLogger = Logger(subsystem: Bundle.main.bundleIdentifier!, category: "Application")
