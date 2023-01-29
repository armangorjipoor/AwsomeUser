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
        
        //MARK: VIEWS
        var userNameInputView: SimpleInputView!
        var passwordInputView: SimpleInputView!
        
        var credentialsStckView: UIStackView!
        
        var loginButton: AGButton!
        var errorLb: UILabel!
        
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
        
        //MARK: SETUP VIEWS
        override func setup() {
            setupViews()
            layoutViews()
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
        
        func setupViews() {
            userNameInputView = SimpleInputView(labelString: "User Name", type: .default)
            passwordInputView = SimpleInputView(labelString: "PassWord", type: .numberPad)
            setupStackView()
            setupLoginButton()
        }
        
        fileprivate func setupStackView() {
            credentialsStckView = UIStackView()
            credentialsStckView.axis = .vertical
            credentialsStckView.spacing = 15
            
            credentialsStckView.addArrangedSubview(userNameInputView)
            credentialsStckView.addArrangedSubview(passwordInputView)
            
            credentialsStckView.translatesAutoresizingMaskIntoConstraints = false
            self.view.addSubview(credentialsStckView)
        }
        
        fileprivate func setupLoginButton() {
            
            loginButton = AGButton()
                .backgroundColor(.red)
                .title("Login")
                .titleColor(.white)
                .icon(UIImage(systemName: "lock.fill")!)
                .borderWidth(1.0)
                .borderColor(.black)
                .borderRadius(10)
            
            loginButton.translatesAutoresizingMaskIntoConstraints = false
            loginButton.addTarget(self, action: #selector(loginBtnTap), for: .touchUpInside)
            self.view.addSubview(loginButton)
            
            NSLayoutConstraint.activate([
                loginButton.topAnchor.constraint(equalTo: credentialsStckView.bottomAnchor, constant: 10),
                loginButton.centerXAnchor.constraint(equalTo: view.centerXAnchor),
                loginButton.widthAnchor.constraint(equalTo: view.widthAnchor, multiplier: 0.7),
                loginButton.heightAnchor.constraint(equalToConstant: 60),
            ])
        }
        
        //MARK: ACTIONS
        @objc func loginBtnTap() {
            if validateForm() {
                viewModel!.model = Model.Login(userName: userNameInputView.text,
                                               password: Int16(passwordInputView.text) ?? 0)
                viewModel!.fetchUserByUserAndPass()
                let path = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask)
                debugPrint(path[0])
            } else {
                print("Error")
            }
    
        }
        //MARK: UTIlS
        func validateForm() -> Bool {
                // Check that all fields are filled
            return !userNameInputView.isEmpty && !passwordInputView.isEmpty
            }
        
        //MARK: BIND
        override func bind() {
            let _ = viewModel?.loginPublisher
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
                }, receiveValue: { [weak self] user in
                    guard let self = self else { return }
                    let homeVM = ViewModel.Home(model: Model.Home(userName: user.userName))
                    self.coordinator.goToHome(home: homeVM)
                })
                .store(in: &subscribers)
        }
        
        private func layoutViews() {
            
            NSLayoutConstraint.activate([
                credentialsStckView.topAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.topAnchor, constant: 20),
                credentialsStckView.leadingAnchor.constraint(equalTo: self.view.leadingAnchor, constant: 20),
                credentialsStckView.trailingAnchor.constraint(equalTo: self.view.trailingAnchor, constant: -20)
            ])
            
        }
        
        //MARK: ALERT
        func showAlert(title: String, message: String) {
            let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)
            let action = UIAlertAction(title: "Ok", style: .default, handler: {_ in
                alert.dismiss(animated: true)
            })
            alert.addAction(action)
            alert.present(self, animated: true)
        }
    }
    
}
