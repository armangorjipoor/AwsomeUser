//
//  ViewController+Base.swift
//  AwsomeUser
//
//  Created by Arman Gorj on 11/7/1401 AP.
//

import UIKit
import Combine

extension ViewController {
    class Base: UIViewController {
        
        // MARK: PROPERTIS
        
        public var subscribers = Set<AnyCancellable>()

        // MARK: OBJECT
        
        override func viewDidLoad() {
            super.viewDidLoad()
            
            setup()
            bind()
            self.view.backgroundColor = .white
        }
        
        // MARK: FUNC
        
        public func setup() {
            
        }
        
        public func bind() {
            
        }
        
        public func setNavBarHidden(){
            if let navController = self.navigationController {
                navController.setNavigationBarHidden(true, animated: false)
            }
        }
        
        
    }
    
}

