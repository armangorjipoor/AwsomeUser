//
//  MainView+Register.swift
//  AwsomeUser
//
//  Created by Arman Gorj on 11/10/1401 AP.
//

import Foundation
import UIKit

extension MainView {
    class Register: UIView {
        
        //MARK: SUBVIEWS
         var fullNameInputView: SimpleInputView!
        var userNameInputView: SimpleInputView!
        var passwordInputView: SimpleInputView!
        
        var errorLb: UILabel!
        
        lazy var credentialsStckView: UIStackView = {
            let sv = UIStackView()
            sv.axis = .vertical
            sv.spacing = 10
            sv.distribution = .fillEqually
            sv.translatesAutoresizingMaskIntoConstraints = false
            return sv
        }()
        
        var registerButton: AGButton!
        
        override init(frame: CGRect) {
            super.init(frame: frame)
            self.backgroundColor = .systemBackground
            setup()
        }
        
        required init?(coder: NSCoder) {
            super.init(coder: coder)
        }
        //MARK: SETUP VIEWS
         func setup() {
            setupViews()
        }
        
        func setupViews() {
            fullNameInputView = SimpleInputView(labelString: "Full name", type: .default, isSecureTextEntry: false)
            userNameInputView = SimpleInputView(labelString: "User name", type: .default, isSecureTextEntry: false)
            passwordInputView = SimpleInputView(labelString: "Password", type: .numberPad, isSecureTextEntry: true)
            setupStackView()
            setupRegisterButton()
            setupErrorLbl()
        }
        
        fileprivate func setupErrorLbl() {
            errorLb = UILabel()
            errorLb.isHidden = true
            errorLb.translatesAutoresizingMaskIntoConstraints = false
            self.addSubview(errorLb)
            errorLb.text = "Error"
            errorLb.textColor = .white
            errorLb.numberOfLines = 0
            errorLb.backgroundColor = .red
        }
        
        fileprivate func setupStackView() {
            credentialsStckView.addArrangedSubview(fullNameInputView)
            credentialsStckView.addArrangedSubview(userNameInputView)
            credentialsStckView.addArrangedSubview(passwordInputView)
            
            self.addSubview(credentialsStckView)
            layoutStackViews()
        }
        
        //MARK: LAYOUTVIEWS
        private func layoutStackViews() {
            
            NSLayoutConstraint.activate([
                credentialsStckView.topAnchor.constraint(equalTo: self.safeAreaLayoutGuide.topAnchor, constant: 20),
                credentialsStckView.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 20),
                credentialsStckView.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: -20),
                credentialsStckView.heightAnchor.constraint(equalToConstant: 200)
            ])
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
            self.addSubview(registerButton)
            
            NSLayoutConstraint.activate([
                registerButton.topAnchor.constraint(equalTo: credentialsStckView.bottomAnchor, constant: 30),
                registerButton.centerXAnchor.constraint(equalTo: self.centerXAnchor),
                registerButton.widthAnchor.constraint(equalTo: self.widthAnchor, multiplier: 0.7),
                registerButton.heightAnchor.constraint(equalToConstant: 60),
            ])
        }
    }
}
