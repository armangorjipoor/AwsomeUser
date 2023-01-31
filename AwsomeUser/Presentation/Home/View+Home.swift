//
//  View+Home.swift
//  AwsomeUser
//
//  Created by Arman Gorj on 11/10/1401 AP.
//

import Foundation
import UIKit

extension MainView {
    class Home: UIView {
        
        //MARK: PROPERTY OBSERVER
        var fullName: String = "" {
            didSet {
                welComLbl.text = "Welcom Dear \(fullName)"
            }
        }
        
        //MARK: SUBVIEWS
        lazy var welcomContainerView: UIView = {
            let v = UIView()
            v.backgroundColor = .green
            v.layer.cornerRadius = 10
            v.translatesAutoresizingMaskIntoConstraints = false
            return v
        }()
        
        lazy var welComLbl: UILabel = {
            let lbl = UILabel()
            lbl.font = UIFont.systemFont(ofSize: 18, weight: .bold)
            lbl.textColor = .white
            lbl.numberOfLines = 0
            lbl.translatesAutoresizingMaskIntoConstraints = false
            return lbl
        }()
        
        lazy var logutCautionLbl: UILabel = {
            let lbl = UILabel()
            lbl.font = UIFont.systemFont(ofSize: 15, weight: .medium)
            lbl.textColor = .black
            lbl.textAlignment = .center
            lbl.numberOfLines = 0
            lbl.text = "You will logout in 15 second"
            lbl.translatesAutoresizingMaskIntoConstraints = false
            return lbl
        }()
        
        lazy var logoutBtn: UIButton = {
            let btn = UIButton()
            btn.setTitle("Logut", for: .normal)
            btn.titleLabel?.font = UIFont.systemFont(ofSize: 15, weight: .bold)
            btn.titleLabel?.textColor = .white
            btn.backgroundColor = .blue
            btn.layer.cornerRadius = 20
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
            setupAndLayoutWelcomView()
            setupAndLayoutWelcomLabel()
            setupAndLayoutCautionLbl()
            setupAndLayoutLogoutBtn()
        }
        
        func setupAndLayoutWelcomView() {
            self.addSubview(welcomContainerView)
            
            NSLayoutConstraint.activate([
                welcomContainerView.topAnchor.constraint(equalTo: self.safeAreaLayoutGuide.topAnchor, constant: 20),
                welcomContainerView.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 20),
                welcomContainerView.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: -20),
                welcomContainerView.heightAnchor.constraint(equalToConstant: 100)
            ])
        }
        
        func setupAndLayoutWelcomLabel() {
            welcomContainerView.addSubview(welComLbl)
            
            NSLayoutConstraint.activate([
                welComLbl.centerXAnchor.constraint(equalTo: welcomContainerView.centerXAnchor),
                welComLbl.centerYAnchor.constraint(equalTo: welcomContainerView.centerYAnchor)
            ])
        }
        
        func setupAndLayoutCautionLbl() {
            self.addSubview(logutCautionLbl)
            
            NSLayoutConstraint.activate([
                logutCautionLbl.topAnchor.constraint(equalTo: welcomContainerView.bottomAnchor, constant: 20),
                logutCautionLbl.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 20),
                logutCautionLbl.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: -20),
                logutCautionLbl.heightAnchor.constraint(equalToConstant: 100)
            ])
        }
        
        func setupAndLayoutLogoutBtn() {
            self.addSubview(logoutBtn)
            
            NSLayoutConstraint.activate([
                logoutBtn.centerXAnchor.constraint(equalTo: self.centerXAnchor),
                logoutBtn.centerYAnchor.constraint(equalTo: self.centerYAnchor),
                logoutBtn.widthAnchor.constraint(equalTo: self.widthAnchor, multiplier: 0.75),
                logoutBtn.heightAnchor.constraint(equalToConstant: 45)
            ])
        }
    }
}
