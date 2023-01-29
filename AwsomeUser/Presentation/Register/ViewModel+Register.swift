//
//  ViewModel+Register.swift
//  AwsomeUser
//
//  Created by Arman Gorj on 11/8/1401 AP.
//

import Foundation
import Combine

extension ViewModel {
    class Register {
        
        @Published var createPublisher = PassthroughSubject<User, UserError>()
        
        private var subscribers = Set<AnyCancellable>()
        private var manager: UserManager
        
        init() {
            manager = UserManager()
        }
        
        func createUser(name: String, userName: String, passWord: Int16) {
            if manager.checkForUserExistentBy(userName: userName) {
                createPublisher.send(completion: .failure(.userExist))
            } else {
                let user = User(fullName: name, userName: userName, password: passWord, id: UUID())
                manager.createUser(user: user)
                createPublisher.send(user)
            }
        }
        
    }
}
