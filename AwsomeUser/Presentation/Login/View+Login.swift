//
//  View+Login.swift
//  AwsomeUser
//
//  Created by Arman Gorj on 11/11/1401 AP.
//

import Foundation
import UIKit

extension MainView {
    class Login: UIView {
        
        lazy var titleLbl: UILabel = {
            let lbl = UILabel()
            lbl.font = UIFont.systemFont(ofSize: 18, weight: .heavy)
            lbl.textColor = .black
            lbl.text = "Please enter your credential here"
            lbl.textAlignment = .center
            lbl.numberOfLines = 0
            lbl.translatesAutoresizingMaskIntoConstraints = false
            return lbl
        }()
        
        var userNameInptView = SimpleInputView(labelString: "User name", type: .none, isSecureTextEntry: false)
        var passwordInptView = SimpleInputView(labelString: "Password", type: .none, isSecureTextEntry: true)
        
        lazy var credentialsStckView: UIStackView = {
            let sv = UIStackView()
            sv.axis = .vertical
            sv.spacing = 10
            sv.distribution = .fillEqually
            sv.translatesAutoresizingMaskIntoConstraints = false
            return sv
        }()
        
        lazy var loginBtn: AGButton = {
            
            let btn  =  AGButton()
                .backgroundColor(.blue)
                .title("Login")
                .titleColor(.white)
                .icon(UIImage(systemName: "person.fill")!)
                .borderWidth(1.0)
                .borderColor(.black)
                .borderRadius(10)
                .tapEffect(.pressLikeStyle)
            
            btn.translatesAutoresizingMaskIntoConstraints = false
            
            return btn
        }()
        
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
            setupAndLayoulTitleLabel()
            setupAndLayoutCredentialSv()
            setupAndLayoutLoginBtn()
        }
        
        private func setupAndLayoulTitleLabel() {
            self.addSubview(titleLbl)
            NSLayoutConstraint.activate([
                titleLbl.topAnchor.constraint(equalTo: self.safeAreaLayoutGuide.topAnchor, constant: 20),
                titleLbl.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 20),
                titleLbl.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: -20),
            ])
        }
        
        private func setupAndLayoutCredentialSv() {
            credentialsStckView.addArrangedSubview(userNameInptView)
            credentialsStckView.addArrangedSubview(passwordInptView)
            
            self.addSubview(credentialsStckView)
            
            NSLayoutConstraint.activate([
                credentialsStckView.topAnchor.constraint(equalTo: titleLbl.bottomAnchor, constant: 20),
                credentialsStckView.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 20),
                credentialsStckView.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: -20),
                credentialsStckView.heightAnchor.constraint(equalToConstant: 150)
            ])
        }
        
        fileprivate func setupAndLayoutLoginBtn() {
            
            self.addSubview(loginBtn)
            
            NSLayoutConstraint.activate([
                loginBtn.topAnchor.constraint(equalTo: credentialsStckView.bottomAnchor, constant: 35),
                loginBtn.centerXAnchor.constraint(equalTo: self.centerXAnchor),
                loginBtn.widthAnchor.constraint(equalTo: self.widthAnchor, multiplier: 0.7),
                loginBtn.heightAnchor.constraint(equalToConstant: 60),
            ])
        }
    }
}
