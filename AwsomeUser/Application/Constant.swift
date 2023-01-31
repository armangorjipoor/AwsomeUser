//
//  Constant.swift
//  AwsomeUser
//
//  Created by Arman Gorj on 11/7/1401 AP.
//

import Foundation

struct Constants {
    
    // specify time to keep user in home page
    static let DESIRED_TIME_KEEP_IN_FORGROUND = 5.0
    static let DESIRED_TIME_KEEP_IN_BACKGROUND = 8.0
    
    //Background Processing
    static let BG_TASK_IDENTIFIER = "com.armanG.AWSomeUser.bgRefresh"
    
    //User Default Keys and Values
    enum UD: String {
        case FIRST_APP_LAUNCH = "first_app_Luanch"
        case USER_LOGED_IN  = "user_logged_in"
        case USER_SUCCESS_LOGIN = "user_loged_in_success_login"
        }

}
