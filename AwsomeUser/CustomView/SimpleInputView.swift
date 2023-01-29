//
//  SimpleInputView.swift
//  AwsomeUser
//
//  Created by Arman Gorj on 11/8/1401 AP.
//

import Foundation
import UIKit

class SimpleInputView: UIView {
    
    private var label: UILabel = UILabel()
    private var textField = UITextField()
    
    var labelString: String!
    var type: UIKeyboardType!
    
    var text: String {
        get {
            self.textField.text ?? ""
        }
        set {
            self.textField.text = newValue
        }
    }
    
    var isEmpty: Bool {
        get {
            if textField.text == nil {
                return false
            } else {
                return true
            }
        }
    }
    init(labelString: String, type: UIKeyboardType?) {
        super.init(frame: .zero)
        
        self.labelString = labelString
        self.type = type
        setup()
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
//        setup()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
//        setup()
    }
    
    func setup() {
        label.translatesAutoresizingMaskIntoConstraints = false
        label.text = labelString
        self.addSubview(label)
        
        textField.translatesAutoresizingMaskIntoConstraints = false
        self.addSubview(textField)
        textField.keyboardType = type
        textField.borderStyle = .roundedRect
        textField.backgroundColor = .lightGray
        
        configureView()
    }
    
    func configureView() {
        NSLayoutConstraint.activate([
            label.topAnchor.constraint(equalTo: self.topAnchor),
            label.bottomAnchor.constraint(equalTo: self.bottomAnchor),
            label.leadingAnchor.constraint(equalTo: self.leadingAnchor),
        ])
        
        NSLayoutConstraint.activate([
            textField.topAnchor.constraint(equalTo: self.topAnchor),
            textField.bottomAnchor.constraint(equalTo: self.bottomAnchor),
            textField.trailingAnchor.constraint(equalTo: self.trailingAnchor),
            textField.leadingAnchor.constraint(equalTo: label.trailingAnchor, constant: 10),
        ])
        
    }
    
}
