//
//  UserManager.swift
//  AwsomeUser
//
//  Created by Arman Gorj on 11/7/1401 AP.
//

import Foundation
import Combine

public struct UserManager
{
    private let _userRepository = UserDataRepository()
    
    public func createUser(user: User) {
        _userRepository.create(user: user)
    }
    
    public func fetchUser(byIdentifier id: UUID) -> User?
    {
        return _userRepository.get(byIdentifier: id)
    }
    
    public func fetchUser(by userName: String, password: Int16)-> User? {
        return _userRepository.getUser(by: userName, password: password)
    }
    
    public  func fetchUserBy(userName: String) -> User?
    {
        return _userRepository.get(byUserName: userName)
    }
    
    public func checkForUserExistentBy(userName: String) -> Bool {
        if fetchUserBy(userName: userName) != nil {
            return true
        } else {
            return false
        }
    }
    
    func fetchUsers() -> [User]? { nil }
    
    func updateUser(employee: User) -> Bool { false }
    
    func deleteUser(id: UUID) -> Bool { false }
}
