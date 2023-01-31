//
//  ViewController+Home.swift
//  AwsomeUser
//
//  Created by Arman Gorj on 11/7/1401 AP.
//

import Foundation
import UIKit
import UserNotifications

 extension ViewController {
     class Home: ViewController.Base {
         
         //MARK: PROPERTIES
         private weak var coordinator: AppCoordinator?
         private var viewModel: ViewModel.Home
         
         //MARK: MAINVIEW
         //view that replace with view controller view
         var mainView = MainView.Home()
         
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
         
         override func loadView() { view = mainView }
         
         override func viewDidLoad() {
             super.viewDidLoad()
             viewModel.fetchUser()
             loggerVC.debug(#function)
         }
         
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
             setNavBarHidden()
         }
         
         func setupViews() {
             mainView.logoutBtn.addTarget(self, action: #selector(logoutBtnTap), for: .touchUpInside)
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
                 }, receiveValue: { [weak self] user in
                     print(user)
                     guard let self = self else { return }
                     self.mainView.fullName = user.fullName
                 })
                 .store(in: &subscribers)
         }
         
     }
}
