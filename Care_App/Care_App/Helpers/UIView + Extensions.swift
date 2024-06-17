//
//  UIView + Extensions.swift
//  Care_App
//
//  Created by Naseem Oyebola on 17/06/2024.
//

import UIKit

public extension UIView {
  func newAnchor(top: NSLayoutYAxisAnchor? = nil,
                  left: NSLayoutXAxisAnchor? = nil,
                  bottom: NSLayoutYAxisAnchor? = nil,
                  right: NSLayoutXAxisAnchor? = nil,
                  paddingTop: CGFloat = 0,
                  paddingLeft: CGFloat = 0,
                  paddingBottom: CGFloat = 0,
                  paddingRight: CGFloat = 0,
                  width: CGFloat? = nil,
                  height: CGFloat? = nil) {

        translatesAutoresizingMaskIntoConstraints = false

        if let top = top {
            topAnchor.constraint(equalTo: top, constant: paddingTop).isActive = true
        }

        if let left = left {
            leftAnchor.constraint(equalTo: left, constant: paddingLeft).isActive = true
        }

        if let bottom = bottom {
            bottomAnchor.constraint(equalTo: bottom, constant: -paddingBottom).isActive = true
        }

        if let right = right {
            rightAnchor.constraint(equalTo: right, constant: -paddingRight).isActive = true
        }

        if let width = width {
            widthAnchor.constraint(equalToConstant: width).isActive = true
        }

        if let height = height {
            heightAnchor.constraint(equalToConstant: height).isActive = true
        }
    }

    @discardableResult func centerX(inView view: UIView) -> Self {
        translatesAutoresizingMaskIntoConstraints = false
        centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        return self
    }

    func centerY(inView view: UIView, leftAnchor: NSLayoutXAxisAnchor? = nil, paddingLeft: CGFloat = 0, constant: CGFloat = 0 ){
        translatesAutoresizingMaskIntoConstraints = false
        centerYAnchor.constraint(equalTo: view.centerYAnchor).isActive = true

        if let left = leftAnchor {
            newAnchor(left: left, paddingLeft: paddingLeft)
        }
    }

    func setDimensions(height: CGFloat, width: CGFloat) {
        translatesAutoresizingMaskIntoConstraints = false
        heightAnchor.constraint(equalToConstant: height).isActive = true
        widthAnchor.constraint(equalToConstant: width).isActive = true
    }

    func setHeight(height: CGFloat) {
        translatesAutoresizingMaskIntoConstraints = false
        heightAnchor.constraint(equalToConstant: height).isActive = true
    }

    func setWidth(width: CGFloat) {
        translatesAutoresizingMaskIntoConstraints = false
        widthAnchor.constraint(equalToConstant: width).isActive = true
    }
}

public extension UIView {
  func fillSuperview(padding: UIEdgeInsets = .zero) {
    translatesAutoresizingMaskIntoConstraints = false
    if let superviewTopAnchor = superview?.topAnchor {
      topAnchor.constraint(equalTo: superviewTopAnchor, constant: padding.top).isActive = true
    }
    
    if let superviewBottomAnchor = superview?.bottomAnchor {
      bottomAnchor.constraint(equalTo: superviewBottomAnchor, constant: -padding.bottom).isActive = true
    }
    
    if let superviewLeadingAnchor = superview?.leadingAnchor {
      leadingAnchor.constraint(equalTo: superviewLeadingAnchor, constant: padding.left).isActive = true
    }
    
    if let superviewTrailingAnchor = superview?.trailingAnchor {
      trailingAnchor.constraint(equalTo: superviewTrailingAnchor, constant: -padding.right).isActive = true
    }
  }
  
  func centerInSuperview(size: CGSize = .zero) {
    translatesAutoresizingMaskIntoConstraints = false
    if let superviewCenterXAnchor = superview?.centerXAnchor {
      centerXAnchor.constraint(equalTo: superviewCenterXAnchor).isActive = true
    }
    
    if let superviewCenterYAnchor = superview?.centerYAnchor {
      centerYAnchor.constraint(equalTo: superviewCenterYAnchor).isActive = true
    }
    
    if size.width != 0 {
      widthAnchor.constraint(equalToConstant: size.width).isActive = true
    }
    
    if size.height != 0 {
      heightAnchor.constraint(equalToConstant: size.height).isActive = true
    }
  }
  
  func centerXInSuperview() {
    translatesAutoresizingMaskIntoConstraints = false
    if let superViewCenterXAnchor = superview?.centerXAnchor {
      centerXAnchor.constraint(equalTo: superViewCenterXAnchor).isActive = true
    }
  }
  
  func centerYInSuperview() {
    translatesAutoresizingMaskIntoConstraints = false
    if let centerY = superview?.centerYAnchor {
      centerYAnchor.constraint(equalTo: centerY).isActive = true
    }
  }
  
  func constrainWidth(constant: CGFloat) {
    translatesAutoresizingMaskIntoConstraints = false
    widthAnchor.constraint(equalToConstant: constant).isActive = true
  }
  
  func constrainHeight(constant: CGFloat) {
    translatesAutoresizingMaskIntoConstraints = false
    heightAnchor.constraint(equalToConstant: constant).isActive = true
  }
}

public extension UIView {
  @IBInspectable var cornerRadius: CGFloat {
    get {
      self.cornerRadius
    } set {
      self.layer.cornerRadius = newValue
    }
  }

  var identifier: String { String(describing: self) }

  @IBInspectable var borderWidth: CGFloat {
    get {
      self.layer.borderWidth
    } set {
      self.layer.borderWidth = newValue
    }
  }

  @IBInspectable var borderColor: UIColor? {
    get {
      guard let color = layer.borderColor else {
        return nil
      }
      return UIColor(cgColor: color)
    }
    set {
      layer.borderColor = newValue?.cgColor
    }
  }
}

public extension UIView {
  var height: CGFloat { frame.height }
  var width: CGFloat { frame.width }

  convenience init(bgColor: UIColor) {
    self.init()
    self.backgroundColor = bgColor
  }

  convenience init(height: CGFloat, bgColor: UIColor? = nil, cornerRadius: CGFloat? = nil) {
    self.init()
    self.backgroundColor = bgColor
    self.cornerRadius = cornerRadius ?? .zero
    self.setHeight(height: height)
  }

  var topSafeArea: CGFloat? {
    UIApplication.shared.windows.first(where: { $0.isKeyWindow })?.safeAreaInsets.top
  }

  @objc
  func doneToolBarPressed() {
    endEditing(true)
  }
}

extension UIView {
    
  public func show() {
    self.isHidden = false
  }
  
  public func hide() {
    self.isHidden = true
  }
  
  public func disableInteraction() {
    isUserInteractionEnabled = false
    alpha = 0.4
  }
  
  public func enableInteraction() {
    isUserInteractionEnabled = true
    alpha = 1
  }
}

public class FooterLabelPrimaryButtonTextView: UIView {
  var completion: (() -> Void)?
  private var labelText: String
  private var buttonTitle: String
  private lazy var labelString = "\(labelText) \(buttonTitle)"

  private lazy var titleLabel = UILabel(text: "", size: 13, textColor: K.AppColors.primarybg ?? UIColor(), alignment: .left, isBold: false)

  public init(labelText: String = "", buttonTitle: String = "", hasBoldButtonText: Bool = true, completion: (() -> Void)?) {
    self.labelText = labelText
    self.buttonTitle = buttonTitle
    self.completion = completion
    super.init(frame: .zero)
    setup()
    configureLabel(labelText: labelText, buttonTitle: buttonTitle, hasBoldButtonText: hasBoldButtonText)
  }

  private func setup() {
    titleLabel.numberOfLines = 2
    titleLabel.adjustsFontSizeToFitWidth = false
//    titleLabel.setLineHeight(spacing: 10)
    setHeight(height: 48)
    addSubview(titleLabel)
    titleLabel.newAnchor(top: topAnchor, left: leftAnchor, right: rightAnchor)
  }

  required init(coder: NSCoder) {
    fatalError("init(coder:) has not been implemented")
  }

  func configureLabel(labelText: String = "", buttonTitle: String = "", hasBoldButtonText: Bool = true) {
      let labelString = "\(labelText) \(buttonTitle)"
      let underlineAttriString = NSMutableAttributedString(string: labelString)
      
      let font: UIFont
      if hasBoldButtonText {
          font = UIFont.boldSystemFont(ofSize: 14) // or your custom font
      } else {
          font = UIFont.systemFont(ofSize: 14) // or your custom font
      }

      let range1 = (labelString as NSString).range(of: buttonTitle)
      underlineAttriString.addAttribute(.underlineStyle, value: NSUnderlineStyle.single.rawValue, range: range1)
      underlineAttriString.addAttribute(.font, value: font, range: range1)
      
      if let primaryColor = K.AppColors.primarybg {
          underlineAttriString.addAttribute(.foregroundColor, value: primaryColor, range: range1)
      } else {
          print("K.AppColors.primarybg is nil")
      }

      titleLabel.attributedText = underlineAttriString
      titleLabel.isUserInteractionEnabled = true
      titleLabel.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(tapLabel(gesture:))))
      
      self.labelString = labelString
      self.buttonTitle = buttonTitle
      titleLabel.layoutIfNeeded()
  }


  public static func create(labelText: String, buttonTitle: String, completion: (() -> Void)? = nil) -> FooterLabelPrimaryButtonTextView {
    let footer = FooterLabelPrimaryButtonTextView(labelText: labelText, buttonTitle: buttonTitle, completion: completion)
    return footer
  }

  func setLabelColor(color: UIColor) {
    titleLabel.textColor = color
  }

  @objc
  func tapLabel(gesture: UITapGestureRecognizer) {
    let termsRange = (labelString as NSString).range(of: buttonTitle)
    if gesture.didTapAttributedTextInLabel(label: titleLabel, inRange: termsRange) {
      self.completion?()
    }
  }
}

private extension UITapGestureRecognizer {
    func didTapAttributedTextInLabel2(label: UILabel, inRange targetRange: NSRange) -> Bool {
        guard let attributedText = label.attributedText else { return false }

        let textStorage = NSTextStorage(attributedString: attributedText)
        let layoutManager = NSLayoutManager()
        textStorage.addLayoutManager(layoutManager)

        let textContainer = NSTextContainer(size: label.bounds.size)
        textContainer.lineFragmentPadding = 0
        textContainer.maximumNumberOfLines = label.numberOfLines
        textContainer.lineBreakMode = label.lineBreakMode
        layoutManager.addTextContainer(textContainer)

        let locationOfTouchInLabel = location(in: label)
        let textBoundingBox = layoutManager.usedRect(for: textContainer)
        let alignmentOffset = (label.bounds.size.width - textBoundingBox.size.width) / 2.0 - textBoundingBox.origin.x
        let textContainerOffset = CGPoint(x: alignmentOffset, y: 0)
        let locationOfTouchInTextContainer = CGPoint(x: locationOfTouchInLabel.x - textContainerOffset.x, y: locationOfTouchInLabel.y - textContainerOffset.y)
        let indexOfCharacter = layoutManager.characterIndex(for: locationOfTouchInTextContainer, in: textContainer, fractionOfDistanceBetweenInsertionPoints: nil)

        return NSLocationInRange(indexOfCharacter, targetRange)
    }
}
