//
//  ViewController+Login.swift
//  AwsomeUser
//
//  Created by Arman Gorj on 11/7/1401 AP.
//

import Foundation
import UIKit

extension ViewController {
    class Login: ViewController.Base, Alertable {
        
        //MARK: PROPERTIES
        public var viewModel: ViewModel.Login?
        private var coordinator: AppCoordinator
        
        //MARK: VIEW
        //view that replace with view controller view
        var mainView = MainView.Login()
        
        //MARK: INITIALIZER
        init(coordinator: AppCoordinator) {
            self.coordinator = coordinator
            viewModel = ViewModel.Login()
            super.init(nibName: nil, bundle: nil)
        }
        
        @available(*, unavailable)
        required init?(coder: NSCoder) {
            fatalError("This class does not support NSCoder")
        }
        override func viewDidLoad() {
            super.viewDidLoad()
            
        }
        
        override func loadView() { self.view = mainView }
        
        //MARK: SETUP
        override func setup() {
            super.setup()
            mainView.loginBtn.addTarget(self, action: #selector(loginBtnTap), for: .touchUpInside)
        }
        
        //MARK: ACTIONS
        @objc func loginBtnTap() {
            if isInputsValid() {
                viewModel!.model = Model.Login(userName: mainView.userNameInptView.text,
                                               password: Int16(mainView.passwordInptView.text) ?? 0)
                viewModel!.fetchUserByUserAndPass()
                Utils.printDocumentDirectory()
            }
            
        }
        //MARK: INPUT VALIDATION
        func isInputsValid() -> Bool {
            // Check that all fields are filled
            
            if mainView.userNameInptView.isEmpty {
                mainView.userNameInptView.showError()
                return false
            } else if mainView.passwordInptView.isEmpty {
                mainView.passwordInptView.showError()
                return false
            } else {
                return true
            }
        }
        //MARK: BIND
        override func bind() {
            let _ = viewModel?.loginPublisher
                .receive(on: RunLoop.main)
                .sink(receiveCompletion: { [weak self] comp in
                    switch comp {
                    case .failure(let error) :
                        guard let self = self else { return }
                        self.showAlert(title: "Error", message: "Probaly user name or password wrong", completion: nil)
                    case .finished:
                        break
                    }
                }, receiveValue: { [weak self] user in
                    guard let self = self else { return }
                    let homeVM = ViewModel.Home(model: Model.Home(userName: user.userName))
                    self.coordinator.goToHome(home: homeVM)
                })
                .store(in: &subscribers)
        }
    }
}
