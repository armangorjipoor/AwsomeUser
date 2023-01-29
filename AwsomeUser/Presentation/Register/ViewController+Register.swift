//
//  ViewController+Register.swift
//  AwsomeUser
//
//  Created by Arman Gorj on 11/7/1401 AP.
//

import Foundation
import UIKit

extension ViewController {
    
    class Register: ViewController.Base {
        
        
        //MARK: PROPERTIES
        private let manager: UserManager = UserManager()
        private var coordinator: AppCoordinator
        
        public var viewModel: ViewModel.Register?
        
        //MARK: VIEWS
        var fullNameInputView: SimpleInputView!
        var userNameInputView: SimpleInputView!
        var passwordInputView: SimpleInputView!
        
        var errorLb: UILabel!
        
        var credentialsStckView: UIStackView!
        
        var registerButton: AGButton!
        
        
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
        
        
        //MARK: SETUP VIEWS
        override func setup() {
            setupViews()
            layoutViews()
        }
        
        func setupViews() {
            fullNameInputView = SimpleInputView(labelString: "FullName", type: .default)
            userNameInputView = SimpleInputView(labelString: "User Name", type: .default)
            passwordInputView = SimpleInputView(labelString: "PassWord", type: .numberPad)
            setupStackView()
            setupRegisterButton()
            setupErrorLbl()
        }
        
        fileprivate func setupErrorLbl() {
            errorLb = UILabel()
            errorLb.isHidden = true
            errorLb.translatesAutoresizingMaskIntoConstraints = false
            self.view.addSubview(errorLb)
            errorLb.text = "Error"
            errorLb.textColor = .white
            errorLb.numberOfLines = 0
            errorLb.backgroundColor = .red
        }
        
        fileprivate func setupStackView() {
            credentialsStckView = UIStackView()
            credentialsStckView.axis = .vertical
            credentialsStckView.spacing = 10
            
            credentialsStckView.addArrangedSubview(fullNameInputView)
            credentialsStckView.addArrangedSubview(userNameInputView)
            credentialsStckView.addArrangedSubview(passwordInputView)
            
            credentialsStckView.translatesAutoresizingMaskIntoConstraints = false
            self.view.addSubview(credentialsStckView)
        }
        
        fileprivate func setupRegisterButton() {
            
            registerButton =  AGButton()
                .backgroundColor(.blue)
                .title("Register")
                .titleColor(.white)
                .icon(UIImage(systemName: "person.fill")!)
                .borderWidth(1.0)
                .borderColor(.black)
                .borderRadius(10)
                .tapEffect(.pressLikeStyle)
            
            registerButton.translatesAutoresizingMaskIntoConstraints = false
            registerButton.addTarget(self, action: #selector(registerBtnTap), for: .touchUpInside)
            self.view.addSubview(registerButton)
            
            NSLayoutConstraint.activate([
                registerButton.topAnchor.constraint(equalTo: credentialsStckView.bottomAnchor, constant: 10),
                registerButton.centerXAnchor.constraint(equalTo: view.centerXAnchor),
                registerButton.widthAnchor.constraint(equalTo: view.widthAnchor, multiplier: 0.7),
                registerButton.heightAnchor.constraint(equalToConstant: 60),
            ])
        }
        
        //MARK: ACTIONS
        @objc func registerBtnTap() {
            if validateForm() {
                viewModel!.createUser(name: fullNameInputView.text,
                                      userName: userNameInputView.text,
                                      passWord: Int16(passwordInputView.text) ?? 0)
                Utils.printDocumentDirectory()
            } else {
                errorLb.isHidden = false
                errorLb.text = "Please fill inputs"
                Utils.wait(3.0, {
                    self.errorLb.isHidden = true
                })
            }
        }
        
        //MARK: UTIlS
        func validateForm() -> Bool {
            // Check that all fields are filled
            if userNameInputView.isEmpty {
                return true
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
                        self.errorLb.isHidden = false
                        self.errorLb.text = error.description
                        Utils.wait(2.0, {
                            self.errorLb.isHidden = true
                            self.coordinator.userLogin()
                        })
                    case .finished:
                        break
                    }
                    
                }, receiveValue: { [weak self] realUser in
                    guard let self = self else { return }
                    let homeVM = ViewModel.Home(model: Model.Home(userName: realUser.userName))
                    self.coordinator.goToHome(home: homeVM)
                })
                .store(in: &subscribers)
        }
        
        //MARK: LAYOUTVIEWS
        private func layoutViews() {
            
            NSLayoutConstraint.activate([
                credentialsStckView.topAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.topAnchor, constant: 20),
                credentialsStckView.leadingAnchor.constraint(equalTo: self.view.leadingAnchor, constant: 20),
                credentialsStckView.trailingAnchor.constraint(equalTo: self.view.trailingAnchor, constant: -20)
            ])
            
            NSLayoutConstraint.activate([
                errorLb.topAnchor.constraint(equalTo: registerButton.bottomAnchor, constant: -10),
                errorLb.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20),
                errorLb.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20),
                errorLb.heightAnchor.constraint(equalToConstant: 50)
            ])
            
        }
        
        
    }
}

