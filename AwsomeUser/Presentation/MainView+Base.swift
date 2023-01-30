//
//  View+Base.swift
//  AwsomeUser
//
//  Created by Arman Gorj on 11/10/1401 AP.
//

import Foundation
import UIKit

extension MainView {
    class Base: UIView {
        let scrollView = UIScrollView()
        let contentView = UIView()
        
        override init(frame: CGRect) {
            super.init(frame: frame)
            self.backgroundColor = .systemBackground
            setupScrollView()
            setupViews()
            NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillShow), name: UIResponder.keyboardDidShowNotification, object: nil)
            NotificationCenter.default.addObserver(self, selector: #selector(keyboardDidShow), name: UIResponder.keyboardWillHideNotification, object: nil)
        }
        
        required init?(coder: NSCoder) {
            super.init(coder: coder)
        }
        
        func setupScrollView() {
            scrollView.translatesAutoresizingMaskIntoConstraints = false
            contentView.translatesAutoresizingMaskIntoConstraints = false
            addSubview(scrollView)
            scrollView.addSubview(contentView)
            scrollView.centerXAnchor.constraint(equalTo: centerXAnchor).isActive = true
            scrollView.widthAnchor.constraint(equalTo: widthAnchor).isActive = true
            scrollView.topAnchor.constraint(equalTo: topAnchor).isActive = true
            scrollView.bottomAnchor.constraint(equalTo: bottomAnchor).isActive = true
            contentView.centerXAnchor.constraint(equalTo: scrollView.centerXAnchor).isActive = true
            contentView.widthAnchor.constraint(equalTo: scrollView.widthAnchor).isActive = true
            contentView.topAnchor.constraint(equalTo: scrollView.topAnchor).isActive = true
            contentView.bottomAnchor.constraint(equalTo: scrollView.bottomAnchor).isActive = true
        }
        
        func setupViews(){
            
        }
        
        
        //MARK: KEYBAORD HANDLING
        @objc func keyboardWillShow(notification: NSNotification) {
            guard let userInfo = notification.userInfo,
                  let frame = (userInfo[UIResponder.keyboardFrameEndUserInfoKey] as? NSValue)?.cgRectValue else { return }
            let contentInset = UIEdgeInsets(top: 0, left: 0, bottom: frame.height, right: 0)
            scrollView.contentInset = contentInset
            
        }
        
        @objc func keyboardDidShow(notification: NSNotification) {
            scrollView.contentInset = .zero
        }
    }
}


/*extension MainView {
 class Base: UIView {
 lazy var scrollView: UIScrollView = {
 let scrollView = UIScrollView()
 scrollView.translatesAutoresizingMaskIntoConstraints = false
 return scrollView
 }()
 
 lazy var contentView: UIView = {
 let view = UIView()
 view.backgroundColor = .green
 view.translatesAutoresizingMaskIntoConstraints = false
 return view
 }()
 
 override init(frame: CGRect) {
 super.init(frame: frame)
 setup()
 }
 
 required init?(coder: NSCoder) {
 super.init(coder: coder)
 setup()
 fatalError("init(coder:) has not been implemented")
 }
 
 func setup() {
 addSubviews()
 layoutViews()
 }
 
 private func addSubviews() {
 addSubview(scrollView)
 scrollView.addSubview(contentView)
 }
 
 private func layoutViews() {
 NSLayoutConstraint.activate([
 scrollView.leadingAnchor.constraint(equalTo: self.leadingAnchor),
 scrollView.trailingAnchor.constraint(equalTo: self.trailingAnchor),
 scrollView.topAnchor.constraint(equalTo: self.topAnchor),
 scrollView.bottomAnchor.constraint(equalTo: self.bottomAnchor)
 ])
 
 NSLayoutConstraint.activate([
 contentView.leadingAnchor.constraint(equalTo: self.scrollView.leadingAnchor),
 contentView.trailingAnchor.constraint(equalTo: self.scrollView.trailingAnchor),
 contentView.topAnchor.constraint(equalTo: self.scrollView.topAnchor),
 contentView.bottomAnchor.constraint(equalTo: self.scrollView.bottomAnchor),
 contentView.widthAnchor.constraint(equalTo: self.widthAnchor)
 ])
 }
 }
 }
 */
