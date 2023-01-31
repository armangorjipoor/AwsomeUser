//
//  SimpleInputView.swift
//  AwsomeUser
//
//  Created by Arman Gorj on 11/8/1401 AP.
//

import Foundation
import UIKit

class SimpleInputView: UIView {
    
    lazy var label: UILabel = {
        let lbl = UILabel()
        lbl.font = UIFont.systemFont(ofSize: 15, weight: .bold)
        lbl.textColor = .black
        lbl.translatesAutoresizingMaskIntoConstraints = false
        return lbl
    }()
    
    lazy var textField: UITextField = {
        let txtField = UITextField()
        txtField.borderStyle = .none
        txtField.layer.borderWidth = 1.0
        txtField.layer.borderColor = UIColor.black.cgColor
        txtField.layer.cornerRadius = 12
        txtField.layer.masksToBounds = false
        txtField.translatesAutoresizingMaskIntoConstraints = false
        return txtField
    }()
    
    var labelString: String!
    var type: UIKeyboardType!
    var isSecureTextEntry: Bool!
    
    var text: String {
        get {
            self.textField.text ?? ""
        }
        set {
            self.textField.text = newValue
        }
    }
    
    var isEmpty: Bool {
        if (self.textField.text ?? "").trimmingCharacters(in: CharacterSet.whitespacesAndNewlines).isEmpty  {
            return true
        } else {
            return false
        }
        
    }
    
    init(labelString: String, type: UIKeyboardType?, isSecureTextEntry: Bool) {
        super.init(frame: .zero)
        
        self.labelString = labelString
        self.type = type
        self.isSecureTextEntry = isSecureTextEntry
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
        label.text = labelString
        self.addSubview(label)
        
        self.addSubview(textField)
        if let type = type {
            textField.keyboardType = type            
        }
        textField.isSecureTextEntry = isSecureTextEntry
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
//            textField.leadingAnchor.constraint(equalTo: label.trailingAnchor, constant: 10),
//            textField.widthAnchor.constraint(equalToConstant: 120)
            textField.widthAnchor.constraint(equalTo: self.widthAnchor, multiplier: 0.7)
        ])
        
    }
    
    func showError() {
        UIView.animate(withDuration: 1.0, animations: { [weak self] in
            guard let self = self else { return }
            self.textField.backgroundColor = UIColor.red
        }, completion: {_ in
            UIView.animate(withDuration: 1.0, animations: { [weak self] in
                guard let self = self else { return }
                self.textField.backgroundColor = UIColor.lightGray
            })
            
            
        })
    }
}
