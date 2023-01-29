//
//  UserError.swift
//  AwsomeUser
//
//  Created by Arman Gorj on 11/8/1401 AP.
//

import Foundation

enum UserError: Error {
    
//    case error(statusCode: Int)
    case userExist
    case noUserFound
}

extension UserError: CustomStringConvertible {
    public var description: String {
        switch self {
        case .userExist:
            return "you already registered, you will move to login"
        case .noUserFound:
            return "Not found user with this credential"
        }
    }
}
