//
//  AGTextField.swift
//  AwsomeUser
//
//  Created by Arman Gorj on 11/9/1401 AP.
//

import Foundation
import UIKit

/*
class AGTextField: UITextField {
    
    //MARK: ANIMATING CONSTANT
    
    /// The value of the title move up from its bounds duration
    @objc dynamic open var titleMoveInDuration: TimeInterval = 0.2
    /// The value of the title move down from its bounds duration
    @objc dynamic open var titleMoveOutDuration: TimeInterval = 0.3
    /// The value of the error style appearing duration
    @objc dynamic open var errorFadeInDuration: TimeInterval = 0.2
    /// The value of the error style disappearing duration
    @objc dynamic open var errorFadeOutDuration: TimeInterval = 0.3
    
    // MARK: SUBVIEWS
    
    /// `UIView` to display the line below the text input.
    open var iconImageView: UIImageView!
    
    /// `UIView` that divide icon from title and placeholder
    open var dividerView: UIImageView!
    
    ///   `UILabel` that act as a placeholder
    open var placeHolderLabel: UILabel!
    
    ///  `UILabel` that displays title of textfield
    open var titleLabel: UILabel!
    
    ///  `UILabel` that displays error messsage in error state
    open var errorLabel: UILabel!
    
    ///  `UIButton` to some change apperance on text like hide and show password
    open var rightButton: UIButton!
    
    // MARK: COLORS
    /// A UIColor value that determines the text color of the editable text
    @IBInspectable
    override dynamic open var textColor: UIColor? {
        set {
            cachedTextColor = newValue
            updateControl(false)
        }
        get {
            return cachedTextColor
        }
    }
    
    /// A UIColor value that determines text color of the placeholder label
    @IBInspectable dynamic open var dividerColor: UIColor = UIColor.lightGray {
        didSet {
            setDividerColor()
        }
    }
    
    @IBInspectable dynamic open var titleColor: UIColor = UIColor.lightGray {
        didSet {
            setTitleColor()
        }
    }
    
    @IBInspectable dynamic open var title: String = "" {
        didSet {
            updateTitleLabel()
        }
    }
    
    @IBInspectable dynamic open var borderColor: UIColor = UIColor.lightGray {
        didSet {
            setBorderColor()
        }
    }
    
    //MARK: PROPERTIES
    
    override open var isSecureTextEntry: Bool {
        set {
            super.isSecureTextEntry = newValue
            
        }
        get {
            return super.isSecureTextEntry
        }
    }
    
    /// A String value for the error message to display.
    @IBInspectable
    open var errorMessage: String? {
        didSet {
            updateControl(true)
        }
    }
    
    /// The text  of the textfield
    @IBInspectable
    override open var text: String? {
        didSet {
            updateControl(false)
        }
    }
    
    @IBInspectable
    dynamic open var iconMarginLeft: CGFloat = 4 {
        didSet {
            updateFrame()
        }
    }
    
    /**
     A float value that determines the bottom margin of the icon.
     Use this value to position the icon more precisely vertically.
     */
    @IBInspectable
    dynamic open var iconMarginBottom: CGFloat = 4 {
        didSet {
            updateFrame()
        }
    }
    
    // MARK: - Initializers
    
    /**
     Initializes the control
     - parameter frame the frame of the control
     */
    override public init(frame: CGRect) {
        super.init(frame: frame)
        initSetupTextField()
    }
    
    
    /// Intialzies the control
    required public init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        initSetupTextField()
    }
    
    fileprivate final func initSetupTextField() {
        borderStyle = .none
        createTitleLabel()
        createDividerView()
        createErrorLabel()
        createIconImageView()
        setColors()
        addEditingChangedObserver()
    }
    
    fileprivate func addEditingChangedObserver() {
        self.addTarget(self, action: #selector(self.editingChanged), for: .editingChanged)
    }
    
    /**
     Invoked when the editing state of the textfield changes. Override to respond to this change.
     */
    @objc open func editingChanged() {
        updateControl(true)
        updateTitleLabel(true)
    }
    
    // MARK: CREATE SUBVIEWS
    
    fileprivate func createTitleLabel() {
        let titleLabel = UILabel()
        titleLabel.autoresizingMask = [.flexibleWidth, .flexibleHeight]
        titleLabel.font = titleFont
        titleLabel.alpha = 0.0
        titleLabel.textColor = titleColor
        
        addSubview(titleLabel)
        self.titleLabel = titleLabel
    }
    
    
    
    fileprivate func createErrorLabel() {
        let errorLabel = UILabel()
        errorLabel.autoresizingMask = [.flexibleWidth, .flexibleHeight]
        errorLabel.font = titleFont
        errorLabel.alpha = 0.0
        errorLabel.textColor = errorColor
        
        addSubview(errorLabel)
        self.errorLabel = errorLabel
    }
    
    fileprivate func createDividerView() {
        
        if lineView == nil {
            let lineView = UIView()
            lineView.isUserInteractionEnabled = false
            self.lineView = lineView
            configureDefaultLineHeight()
        }
        
        lineView.autoresizingMask = [.flexibleWidth, .flexibleTopMargin]
        addSubview(lineView)
    }
    
    fileprivate func createIconImageView() {
        let iconImageView = UIImageView()
        iconImageView.backgroundColor = .clear
        iconImageView.contentMode = .scaleAspectFit
        iconImageView.autoresizingMask = [.flexibleTopMargin, .flexibleRightMargin]
        self.iconImageView = iconImageView
        self.templateImage = true
        addSubview(iconImageView)
    }
    // MARK: RESPONDING HANDLING
    
    ///Attempt the control to become the first responder
    
    @discardableResult
    override open func becomeFirstResponder() -> Bool {
        let result = super.becomeFirstResponder()
        updateControl(true)
        return result
    }
    
    //TODO: create this feature
    /// update colors when is enabled or disbled
//    override open var isEnabled: Bool {
//        didSet {
//            setControl()
//        }
//    }
    
    // MARK: - Color updates
    
    /// Update the colors for the control. Override to customize colors.
    open func setColors() {
        setDividerColor()
        setTitleColor()
        setTextColor()
    }
    
    
    fileprivate func setDividerColor() {
        guard let dividerView = dividerView else { return }
        dividerView.backgroundColor = divierColor
    }
    
    fileprivate func setTitleColor() {
        guard let titleLabel = titleLabel else { return }
        titleLabel.textColor = titleColor
    }
    
    fileprivate func setTextColor() {
        super.textColor = textColor
    }
    
    // MARK: - Title handling
    
    fileprivate func updateTitleLabel(_ animated: Bool = false) {
        guard let titleLabel = titleLabel else { return }
        
        //TODO: change this line to another place
        titleLabel.text = title
//        titleLabel.font = titleFont
        updateTitleVisibility(animated)
  
    }
    // MARK: - SUBVIEW UPDATES
    
    fileprivate func updateControl(_ animated: Bool = false) {
        updateColors()
        updateLineView()
        updateTitleLabel(animated)
    }
    
    // MARK: - COLOR UPDATES
    
    /// Update the colors for the control. Override to customize colors.
    open func updateColors() {
        setBorderColor()
        updateTitleColor()
        updateTextColor()
        updateErrorLabelColor()
    }
    
    //NOTE: Propaly use this for update border color
    fileprivate func updateLineColor() {
        //        guard let lineView = lineView else {
        //            return
        //        }
        //
        //        if !isEnabled {
        //            lineView.backgroundColor = disabledColor
        //        } else if hasErrorMessage {
        //            lineView.backgroundColor = lineErrorColor ?? errorColor
        //        } else {
        //            lineView.backgroundColor = editingOrSelected ? selectedLineColor : lineColor
        //        }
    }
    
    fileprivate func updatePlaceholderColor() {
        guard let titleLabel = titleLabel else {
            return
        }
        
        if !isEnabled {
            titleLabel.textColor = disabledColor
        } else if hasErrorMessage && errorMessagePlacement == .default {
            titleLabel.textColor = titleErrorColor ?? errorColor
        } else {
            if editingOrSelected || isHighlighted {
                titleLabel.textColor = selectedTitleColor
            } else {
                titleLabel.textColor = titleColor
            }
        }
    }
    
    fileprivate func setBorderColor() {
        self.layer.borderColor = borderColor.cgColor
    }
    
    fileprivate var _palceHolderVisible: Bool = false
    
    /*
     *   Set this value to make the title visible
     */
    open func setTitleVisible(
        _ titleVisible: Bool,
        animated: Bool = false,
        animationCompletion: ((_ completed: Bool) -> Void)? = nil
    ) {
        if _titleVisible == titleVisible {
            return
        }
        _titleVisible = titleVisible
        updateTitleColor()
        updateTitleVisibility(animated, completion: animationCompletion)
    }
    
    /**
     Returns whether the title is being displayed on the control.
     - returns: True if the title is displayed on the control, false otherwise.
     */
//    open func isErrorVisible() -> Bool {
//        if errorMessagePlacement == .default {
//            return hasText || hasErrorMessage || _titleVisible
//        } else {
//            return hasText || _titleVisible
//        }
//        self.hasText
//    }
    
//    open func isErrorVisible() -> Bool {
//        return hasErrorMessage
//    }
    
    /*
    fileprivate func updateTitleVisibility(_ animated: Bool = false, completion: ((_ completed: Bool) -> Void)? = nil) {
        let alpha: CGFloat = isTitleVisible() ? 1.0 : 0.0
        let frame: CGRect = titleLabelRectForBounds(bounds, editing: isTitleVisible())
        let updateBlock = { () -> Void in
            self.titleLabel.alpha = alpha
            self.titleLabel.frame = frame
        }
        if animated {
#if swift(>=4.2)
            let animationOptions: UIView.AnimationOptions = .curveEaseOut
#else
            let animationOptions: UIViewAnimationOptions = .curveEaseOut
#endif
            let duration = isTitleVisible() ? titleFadeInDuration : titleFadeOutDuration
            UIView.animate(withDuration: duration, delay: 0, options: animationOptions, animations: { () -> Void in
                updateBlock()
            }, completion: completion)
        } else {
            updateBlock()
            completion?(true)
        }
    }*/
    
    fileprivate func updateErrorVisibility(_ animated: Bool = false, completion: ((_ completed: Bool) -> Void)? = nil) {
        let alpha: CGFloat = isErrorVisible() ? 1.0 : 0.0
        let frame: CGRect = errorLabelRectForBounds(bounds, editing: isErrorVisible())
        let updateBlock = { () -> Void in
            self.errorLabel.alpha = alpha
            self.errorLabel.frame = frame
        }
        if animated {
            let animationOptions: UIView.AnimationOptions = .curveEaseOut
            let duration = isErrorVisible() ? titleFadeInDuration : titleFadeOutDuration
            UIView.animate(withDuration: duration, delay: 0, options: animationOptions, animations: { () -> Void in
                updateBlock()
            }, completion: completion)
        } else {
            updateBlock()
            completion?(true)
        }
    }
    
    // MARK: - UITEXTFIELD text/placeholder positioning overrides
    
    
    override open func textRect(forBounds bounds: CGRect) -> CGRect {
        let superRect = super.textRect(forBounds: bounds)
        let titleHeight = self.titleHeight()
        var height = superRect.size.height - titleHeight - selectedLineHeight
        if errorMessagePlacement == .bottom {
            height -= errorHeight()
        }
        let rect = CGRect(
            x: superRect.origin.x,
            y: titleHeight,
            width: superRect.size.width,
            height: height
        )
        return rect
    }
    
    /**
     Calculate the rectangle for the textfield when it is being edited
     - parameter bounds: The current bounds of the field
     - returns: The rectangle that the textfield should render in
     */
    override open func editingRect(forBounds bounds: CGRect) -> CGRect {
        let superRect = super.editingRect(forBounds: bounds)
        let titleHeight = self.titleHeight()
        
        var height = superRect.size.height - titleHeight - selectedLineHeight
        if errorMessagePlacement == .bottom {
            height -= errorHeight()
        }
        
        let rect = CGRect(
            x: superRect.origin.x,
            y: titleHeight,
            width: superRect.size.width,
            height: height
        )
        return rect
    }
    
    override open func placeholderRect(forBounds bounds: CGRect) -> CGRect {
        var height = bounds.size.height - titleHeight() - selectedLineHeight
        if errorMessagePlacement == .bottom {
            height -= errorHeight()
        }
        let rect = CGRect(
            x: 0,
            y: titleHeight(),
            width: bounds.size.width,
            height: height
        )
        return rect
    }
    
    open func titleLabelRectForBounds(_ bounds: CGRect, editing: Bool) -> CGRect {
        if editing {
            return CGRect(x: 0, y: 0, width: bounds.size.width, height: titleHeight())
        }
        return CGRect(x: 0, y: titleHeight(), width: bounds.size.width, height: titleHeight())
    }
    
    open func errorLabelRectForBounds(_ bounds: CGRect, editing: Bool) -> CGRect {
        if errorMessagePlacement == .default {
            return CGRect.zero
        } else {
            let lineRect = lineViewRectForBounds(bounds, editing: editing)
            if editing {
                let originY = lineRect.origin.y + selectedLineHeight
                return CGRect(x: 0, y: originY, width: bounds.size.width, height: errorHeight())
            }
            let originY = lineRect.origin.y + selectedLineHeight + errorHeight()
            return CGRect(x: 0, y: originY, width: bounds.size.width, height: errorHeight())
        }
    }
    
    open func dividerViewRectForBounds(_ bounds: CGRect, editing: Bool) -> CGRect {
        let height = editing ? selectedLineHeight : lineHeight
        if errorMessagePlacement == .bottom {
            return CGRect(x: 0, y: textRect(forBounds: bounds).maxY, width: bounds.size.width, height: height)
        } else {
            return CGRect(x: 0, y: bounds.size.height - height, width: bounds.size.width, height: height)
        }
    }
    
    open func titleHeight() -> CGFloat {
        if let titleLabel = titleLabel,
           let font = titleLabel.font {
            return font.lineHeight
        }
        return 15.0
    }
    

    open func errorHeight() -> CGFloat {
        if let errorLabel = errorLabel,
           let font = errorLabel.font {
            return font.lineHeight
        }
        return 15.0
    }
    
    /**
     Calculate the height of the textfield.
     -returns: the calculated height of the textfield. Override to size the textfield with a different height
     */
    open func textHeight() -> CGFloat {
        guard let font = self.font else {
            return 0.0
        }
        
        return font.lineHeight + 7.0
    }
    
    /// Invoked by layoutIfNeeded automatically
    override open func layoutSubviews() {
        super.layoutSubviews()
        
        titleLabel.frame = titleLabelRectForBounds(bounds, editing: isTitleVisible() || _renderingInInterfaceBuilder)
        errorLabel.frame = errorLabelRectForBounds(bounds, editing: isErrorVisible() || _renderingInInterfaceBuilder)
        dividerView.frame = lineViewRectForBounds(bounds, editing: editingOrSelected || _renderingInInterfaceBuilder)
        iconImgView.frame =
        palceholderLbl.frame =
    }
    
}
*/
