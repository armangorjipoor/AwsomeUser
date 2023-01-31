//
//  Alertable.swift
//  AwsomeUser
//
//  Created by Arman Gorj on 11/11/1401 AP.
//

import Foundation
import UIKit

public protocol Alertable {}

public extension Alertable where Self: UIViewController {
    
    func showAlert(title: String , message: String, preferredStyle: UIAlertController.Style = .alert, completion: (() -> Void)? ) {
        let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "OK", style: UIAlertAction.Style.default, handler: {_ in 
            (completion ?? {})()
        }))
        self.present(alert, animated: true, completion: nil)
    }
}
