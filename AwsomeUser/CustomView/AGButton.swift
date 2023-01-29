//
//  AGButton.swift
//  AwsomeUser
//
//  Created by Arman Gorj on 11/9/1401 AP.
//

import Foundation
import UIKit

enum ButtonTapEffect {
    case appleStyle
    case fadeStyle
    case pressLikeStyle
    case damping
    case none
}

@IBDesignable class AGButton: UIControl {
    
    //MARK: VIEWS
    private var titleLbl: UILabel!
    private var subTitleLbl: UILabel!
    private var titlesStackView: UIStackView!
    private var iconImgV: UIImageView!
    
    //MARK: TAP STYLE
    var tapEffect: ButtonTapEffect = .none
    
    //MARK: INPECTABLE PROPERTIES
    @IBInspectable var title: String? = "" {
        didSet {
            setup()
        }
    }
    
    @IBInspectable var titleFont: UIFont? = UIFont() {
        didSet {
            setup()
        }
    }
    
    @IBInspectable var titleColor: UIColor? = .clear {
        didSet {
            setup()
        }
    }
    
    @IBInspectable var subTitle: String? = "" {
        didSet {
            setup()
        }
    }
    
    @IBInspectable var subTitleFont: UIFont? = UIFont() {
        didSet {
            setup()
        }
    }
    
    @IBInspectable var subTitleColor: UIColor? = .clear {
        didSet {
            setup()
        }
    }
    
    @IBInspectable public var borderColor: UIColor = UIColor.white {
        didSet {
            setup()
        }
    }
    
    @IBInspectable public var borderWidth: CGFloat = 0.0 {
        didSet {
            setup()
        }
    }
    
    @IBInspectable public var borderRadius: CGFloat = 0.0 {
        didSet {
            setup()
        }
    }
    
    @IBInspectable public var shadowOffset: CGSize = CGSize.init(width:0, height:0) {
        didSet{
            setup()
        }
    }
    
    @IBInspectable public var shadowRadius: CGFloat = 0 {
        didSet{
            setup()
        }
    }
    
    @IBInspectable public var shadowOpacity: CGFloat = 1 {
        didSet{
            setup()
        }
    }
    
    @IBInspectable public var shadowColor: UIColor = UIColor.black {
        didSet{
            setup()
        }
    }
    
    
    @IBInspectable var icon: UIImage? = UIImage() {
        didSet {
            setup()
        }
    }
    

    
    override init(frame: CGRect) {
        super.init(frame: frame)
        configureSubViews()
        setup()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        configureSubViews()
        setup()
    }
    
    fileprivate func configureSubViews() {
        titleLbl = UILabel()
        subTitleLbl = UILabel()
        titlesStackView = UIStackView()
        iconImgV = UIImageView()
        
        iconImgV.contentMode = .scaleAspectFit
        
        titleLbl.translatesAutoresizingMaskIntoConstraints = false
        subTitleLbl.translatesAutoresizingMaskIntoConstraints = false
        titlesStackView.translatesAutoresizingMaskIntoConstraints = false
        iconImgV.translatesAutoresizingMaskIntoConstraints = false
        
        self.addSubview(iconImgV)
        self.addSubview(titlesStackView)
        
        // disable user interaction so button can action can fire
        titleLbl.isUserInteractionEnabled = false
        subTitleLbl.isUserInteractionEnabled = false
        titlesStackView.isUserInteractionEnabled = false
        
        titlesStackView.axis = .vertical
        
        self.titlesStackView.addArrangedSubview(titleLbl)
        self.titlesStackView.addArrangedSubview(subTitleLbl)
        
        layoutSubViews()
    }
    
    fileprivate func layoutSubViews() {
        NSLayoutConstraint.activate([
            titlesStackView.centerYAnchor.constraint(equalTo: self.centerYAnchor),
            titlesStackView.centerXAnchor.constraint(equalTo: self.centerXAnchor)
        ])
        
        NSLayoutConstraint.activate([
            iconImgV.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 5),
            iconImgV.centerYAnchor.constraint(equalTo: self.centerYAnchor),
            iconImgV.heightAnchor.constraint(equalToConstant: 30),
            iconImgV.widthAnchor.constraint(equalToConstant: 30),
        ])
        
    }
    
    func setup() {
//        self.titleLbl.font = titleFont
        self.titleLbl.text = title
        self.titleLbl.textColor = titleColor
        
//        self.subTitleLbl.font = titleFont
        self.subTitleLbl.text = subTitle
        self.subTitleLbl.textColor = subTitleColor
        
        self.iconImgV.image = icon
        setupBorderAndCorners()
        setupShadow()
        
        self.addTarget(self, action: #selector(performEffect), for: .touchUpInside)
    }
    
    fileprivate func setupBorderAndCorners() {
        self.layer.cornerRadius = borderRadius
        self.layer.borderColor = borderColor.cgColor
        self.layer.borderWidth = borderWidth
    }
    
    fileprivate func setupShadow(){
        if shadowRadius > 0 {
            layer.shadowOffset = shadowOffset
            layer.shadowRadius = shadowRadius
            layer.shadowOpacity = Float(shadowOpacity)
            layer.shadowColor = shadowColor.cgColor
        }
    }
    
    //MARK: TAP EFFECT
    @objc func performEffect() {
        switch tapEffect {
        case .appleStyle:
            performAppleStyleEffect()
        case .fadeStyle:
            performFadeStyleEffect()
        case .pressLikeStyle:
            performPressLikeEffect()
        case .damping:
            performEffect()
        case .none:
            break
        }
    }
    
    private func performAppleStyleEffect() {
        
        UIView.animate(withDuration: 0.5,
                       animations: { [weak self] in
            guard let self = self else { return }
            self.titleLbl.alpha = 0.1
            self.subTitleLbl.alpha = 0.1
        },completion: {[weak self] _ in
            guard let self = self else { return }
            self.titleLbl.alpha = 1.0
            self.subTitleLbl.alpha = 1.0
        })
    }
    
    private func performFadeStyleEffect() {
        
    }
    
    private func performDampingStyle() {
        UIView.animate (withDuration: 0.5, delay: 0, usingSpringWithDamping: 0.2,
                        initialSpringVelocity: 0.5, options: .curveEaseIn, animations:{
            self.transform = CGAffineTransform(scaleX: 0.92, y: 0.92)
        }) { _ in
            UIView.animate(withDuration: 0.15,
                           delay: 0,
                           usingSpringWithDamping: 0.4,
                           initialSpringVelocity:2,
                            options: .curveEaseIn, animations: {
                self.transform = CGAffineTransform(scaleX: 1, y: 1)
            }, completion: nil)
        }
    }
    
    private func performPressLikeEffect() {
        UIView.animate(withDuration: 0.2, delay: 0, animations: {
            self.center.y += 5
        }) {_ in
            UIView.animate(withDuration: 0.2, delay: 0, animations: {
                self.center.y -= 5
            })
        }
    }
    
}


extension AGButton {
    
    func backgroundColor(_ color: UIColor) -> Self {
        self.backgroundColor = color
        return self
    }
    
    func title(_ title: String) -> Self {
        self.title = title
        return self
    }
    
    func titleColor(_ color: UIColor) -> Self {
        self.titleColor = color
        return self
    }
    
    func subTitle(_ subTitle: String) -> Self {
        self.subTitle = subTitle
        return self
    }
    
    func subTitleColor(_ subTitleColor: UIColor) -> Self {
        self.subTitleColor = subTitleColor
        return self
    }
    
    func icon(_ icon: UIImage) -> Self {
        self.icon = icon
        return self
    }
    
    func borderColor(_ color: UIColor) -> Self {
        self.borderColor = color
        return self
    }
    
    func borderWidth(_ width: CGFloat) -> Self {
        self.borderWidth = width
        return self
    }
    
    func borderRadius(_ radius: CGFloat) -> Self {
        self.borderRadius = radius
        return self
    }
    
    func tapEffect(_ effect: ButtonTapEffect) -> Self {
        self.tapEffect = effect
        return self
    }
}
