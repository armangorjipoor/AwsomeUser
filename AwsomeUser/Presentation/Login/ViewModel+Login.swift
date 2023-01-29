//
//  ViewModel+Login.swift
//  AwsomeUser
//
//  Created by Arman Gorj on 11/8/1401 AP.
//

import Foundation
import Combine

extension ViewModel {
    class Login {
        
        @Published var loginPublisher = PassthroughSubject<User, UserError>()
        
        private var subscribers = Set<AnyCancellable>()
        private var manager: UserManager
        var model: Model.Login!
        
        init() {
            manager = UserManager()
        }
        
        func fetchUserByUserAndPass() {
            
            if let fetchedUser = manager.fetchUser(by: model.userName, password: model.password) {
                loginPublisher.send(fetchedUser)
            } else {
                loginPublisher.send(completion: .failure(.noUserFound))
            }
        }
    }
}
