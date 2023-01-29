//
//  ViewModel.swift
//  AwsomeUser
//
//  Created by Arman Gorj on 11/8/1401 AP.
//

import Foundation
import Combine

extension ViewModel {
    class Home {
        
        @Published var fetchPublisher = PassthroughSubject<User, UserError>()
        
        private var subscribers = Set<AnyCancellable>()
        private var manager: UserManager
        private var model: Model.Home
        
        init(model: Model.Home) {
            manager = UserManager()
            self.model = model
        }
        
        func fetchUser() {
            if let fetchedUser = manager.fetchUserBy(userName: model.userName) {
                fetchPublisher.send(fetchedUser)
            } else {
                fetchPublisher.send(completion: .failure(.noUserFound))
            }
        }
    }
}
