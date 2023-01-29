//
//  AppCoordinator.swift
//  AwsomeUser
//
//  Created by Arman Gorj on 11/7/1401 AP.
//

import Foundation
import UIKit

class AppCoordinator {
    // MARK: - Properties
    
    var navigationController: UINavigationController?
    var window: UIWindow
    
    // MARK: - Initializers
    
    init(window: UIWindow, appRoute: AppRoute) {
        self.window = window
        startApp(with: appRoute)
    }
    
    // MARK: FUNCTIONS
    
    func startApp(with: AppRoute) {
        var nav: UINavigationController
        switch with {
        case .login:
             nav = UINavigationController(rootViewController: ViewController.Login(coordinator: self))
        case .register:
            nav = UINavigationController(rootViewController: ViewController.Register(coordinator: self))
        }
        navigationController = nav
        window.rootViewController = nav
        window.makeKeyAndVisible()
    }
    
    public func startApp() {
        ////        let viewController = ViewController.Search()
        ////        viewController.fill(self, viewModel: ViewModel.Search())  }
    }
    public func userRegisteration() {
        
    }
    
    public func userLogin() {
        let viewController = ViewController.Login(coordinator: self)
        navigationController?.pushViewController(viewController, animated: true)
    }
    
    public func goToHome(home viewModel: ViewModel.Home) {
        let viewController = ViewController.Home(coordinator: self, viewModel: viewModel)
        navigationController?.pushViewController(viewController, animated: true)
    }
}
