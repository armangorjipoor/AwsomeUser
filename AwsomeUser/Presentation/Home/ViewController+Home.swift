//
//  ViewController+Home.swift
//  AwsomeUser
//
//  Created by Arman Gorj on 11/7/1401 AP.
//

import Foundation
import UIKit
import UserNotifications
import os.log

private let logger = Logger(subsystem: Bundle.main.bundleIdentifier!, category: "ViewController")
 extension ViewController {
     class Home: ViewController.Base {
         
         //MARK: PROPERTIES
         private weak var coordinator: AppCoordinator?
         private var viewModel: ViewModel.Home
         
         //MARK: VIEWS
         var welcomeLbl: UILabel!
         var fullNameLbl: UILabel!
         var logoutBtn: AGButton!
         
         //MARK: INITIALIZER
         init(coordinator: AppCoordinator, viewModel: ViewModel.Home) {
             self.coordinator = coordinator
             self.viewModel = viewModel
             
             super.init(nibName: nil, bundle: nil)
         }
         
         @available(*, unavailable)
         required init?(coder: NSCoder) {
             fatalError("This class does not support NSCoder")
         }
         
         //MARK: VIEW CONTROLLER LYFECYCLE
         override func viewDidLoad() {
             super.viewDidLoad()
             viewModel.fetchUser()
             logger.debug(#function)

             UNUserNotificationCenter.current().requestAuthorization(options: [.alert, .sound]) { granted, error in
                 if let error = error {
                     logger.error("\(error.localizedDescription, privacy: .public)")
                 }
             }         }
         
         override func viewWillAppear(_ animated: Bool) {
             Application.shared.isIUserInHomeScreen = true
             if let coordinator = self.coordinator {
                 let appManager = AppManager(coordinator: coordinator)
                 appManager.didUserInHome()
             }
         }
         
         //MARK: SETUP VIEWS
         override func setup() {
             setupViews()
             layoutViews()
             setNavBarHidden()
             setupLogoutButton()
         }
         fileprivate func setupLogoutButton() {
             
             logoutBtn = AGButton()
                 .backgroundColor(.red)
                 .title("Logout")
                 .titleColor(.white)
                 .icon(UIImage(systemName: "lock.fill")!)
                 .borderWidth(1.0)
                 .borderColor(.black)
                 .borderRadius(10)
             
             logoutBtn.translatesAutoresizingMaskIntoConstraints = false
             logoutBtn.addTarget(self, action: #selector(logoutBtnTap), for: .touchUpInside)
             self.view.addSubview(logoutBtn)
             
             NSLayoutConstraint.activate([
                logoutBtn.topAnchor.constraint(equalTo: fullNameLbl.bottomAnchor, constant: 10),
                logoutBtn.centerXAnchor.constraint(equalTo: view.centerXAnchor),
                logoutBtn.widthAnchor.constraint(equalTo: view.widthAnchor, multiplier: 0.7),
                logoutBtn.heightAnchor.constraint(equalToConstant: 60),
             ])
         }
         
         func setupViews() {
             setupLabels()
         }
         
         func setupLabels() {
             welcomeLbl = UILabel()
             welcomeLbl.text = "Welcom"
             welcomeLbl.textColor = .black
             welcomeLbl.translatesAutoresizingMaskIntoConstraints = false
             view.addSubview(welcomeLbl)
             
             fullNameLbl = UILabel()
             fullNameLbl.textColor = .black
             fullNameLbl.translatesAutoresizingMaskIntoConstraints = false
             view.addSubview(fullNameLbl)
         }
         
         private func layoutViews() {
             NSLayoutConstraint.activate([
                welcomeLbl.topAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.topAnchor, constant: 30),
                welcomeLbl.centerXAnchor.constraint(equalTo: self.view.centerXAnchor)
             ])
             
             NSLayoutConstraint.activate([
                fullNameLbl.centerXAnchor.constraint(equalTo: self.view.centerXAnchor),
                fullNameLbl.centerYAnchor.constraint(equalTo: self.view.centerYAnchor)
             ])
             
         }
         
         
         //MARK: ACTIONS
         @objc func logoutBtnTap() {
             if let coordinator = coordinator {
                 coordinator.userLogin()                 
             }
         }
         
         //MARK: BIND
         override func bind() {
            let _ = viewModel.fetchPublisher
                 .receive(on: RunLoop.main)
                 .sink(receiveCompletion: { [weak self] comp in
                     print("🌹\(comp)")
                 }, receiveValue: { user in
                     print(user)
                     self.fullNameLbl.text = user.fullName
                 })
                 .store(in: &subscribers)
         }
         
     }
}
