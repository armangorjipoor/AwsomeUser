//
//  ViewController+Register.swift
//  AwsomeUser
//
//  Created by Arman Gorj on 11/7/1401 AP.
//

import Foundation
import UIKit

extension ViewController {
    
    class Register: ViewController.Base, Alertable {
        
        //MARK: PROPERTIES
        private let manager: UserManager = UserManager()
        weak var coordinator: AppCoordinator?
        
        public var viewModel: ViewModel.Register?
        
        //view that replace with view controller view
        var mainView = MainView.Register()
        
        //MARK: INITIALIZER
        init(coordinator: AppCoordinator) {
            self.coordinator = coordinator
            self.viewModel = ViewModel.Register()
            super.init(nibName: nil, bundle: nil)
        }
        
        @available(*, unavailable)
        required init?(coder: NSCoder) {
            fatalError("This class does not support NSCoder")
        }
        
        
        //MARK: VIEWCONTROLLER LYFECYCLE
        override func viewDidLoad() {
            super.viewDidLoad()
        }
        
        override func loadView() { self.view = mainView }
        
        override func setup() {
            super.setup()
            mainView.registerButton.addTarget(self, action: #selector(registerBtnTap), for: .touchUpInside)
        }
        
        //MARK: ACTIONS
        @objc func registerBtnTap() {
            if isInputsValid() {
                viewModel!.createUser(name: mainView.fullNameInputView.text,
                                      userName: mainView.userNameInputView.text,
                                      passWord: Int16(mainView.passwordInputView.text) ?? 0)
                Utils.printDocumentDirectory()
            }
        }
        
        //MARK: INPUT VALIDATION
        func isInputsValid() -> Bool {
            // Check that all fields are filled
            if mainView.fullNameInputView.isEmpty {
                mainView.fullNameInputView.showError()
                return false
            } else if mainView.userNameInputView.isEmpty {
                mainView.userNameInputView.showError()
                return false
            } else if mainView.passwordInputView.isEmpty {
                mainView.passwordInputView.showError()
                return false
            } else {
                return true
            }
        }
        
        //MARK: BIND
        override func bind() {
            viewModel?.createPublisher
                .receive(on: RunLoop.main)
                .sink(receiveCompletion: { [weak self] comp in
                    switch comp {
                    case .failure(let error) :
                        guard let self = self else { return }
                        
                        self.showAlert(title: "Note",
                                       message: error.description,
                                       preferredStyle: .alert) {
                            if let coordinator = self.coordinator {
                                coordinator.userLogin()
                            }
                        }
                        
                    case .finished:
                        break
                    }
                    
                }, receiveValue: { [weak self] realUser in
                    guard let self = self else { return }
                    let homeVM = ViewModel.Home(model: Model.Home(userName: realUser.userName))
                    if let coordinator = self.coordinator {
                        self.showAlert(title: "Success",
                                  message: "You register was Successfull", completion: {
                            coordinator.goToHome(home: homeVM)
                        })
                    }
                    
                })
                .store(in: &subscribers)
        }
        
    }
}

