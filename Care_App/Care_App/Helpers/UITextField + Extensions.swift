//
//  UITextField + Extensions.swift
//  Care_App
//
//  Created by Naseem Oyebola on 17/06/2024.
//

import UIKit

public enum ViewPlacementEnum {
  case left, right
}

public extension UITextField {
  convenience init(_ placeholder: String? = nil) {
    self.init(frame: .zero)
    self.placeholder = placeholder
    font = UIFont(name: "Roboto-Regular", size: 13)!
    textColor = K.AppColors.textPrimary
    backgroundColor = .white
    layer.borderColor = UIColor.lightGray.cgColor
    layer.borderWidth = 1
    layer.cornerRadius = 8
    translatesAutoresizingMaskIntoConstraints = false
    setHeight(height: 55)
    setLeftPaddingPoints(18)

    let attributes: [NSAttributedString.Key: Any] = [
      .foregroundColor: K.AppColors.textPrimary?.withAlphaComponent(0.5) ?? UIColor.black,
      .font: UIFont(name: "Roboto-Regular", size: 14)!
       ]
    attributedPlaceholder = NSAttributedString(string: placeholder ?? "", attributes: attributes)
  }

  func addAccessoryView(_ text: String, frame: CGRect, position: ViewPlacementEnum) {
    let view = UIView(frame: frame)
    switch position {
    case .left:
      leftView = view
      leftViewMode = .always

    case .right:
      rightView = view
      rightViewMode = .always
    }
  }

  func setLeftPaddingPoints(_ amount: CGFloat) {
    let paddingView = UIView(frame: CGRect(x: 0, y: 0, width: amount, height: self.frame.size.height))
    self.leftView = paddingView
    self.leftViewMode = .always
  }

  func setRightPaddingPoints(_ amount: CGFloat) {
    let paddingView = UIView(frame: CGRect(x: 0, y: 0, width: amount, height: self.frame.size.height))
    self.rightView = paddingView
    self.rightViewMode = .always
  }

  func setRightIcon(_ image: String) {
    let iconView = UIImageView(frame:
                                CGRect(x: -10, y: 5, width: 20, height: 20))
    iconView.image = UIImage(named: image)
    let iconContainerView = UIView(frame:
                                    CGRect(x: -13, y: 0, width: 30, height: 30))
    iconContainerView.addSubview(iconView)
    rightView = iconContainerView
    rightViewMode = .always
  }

  func setTexfieldDropdownRightImage(imageName: String) {
    let iconView = UIImageView(frame:
                                CGRect(x: -10, y: 12, width: 17, height: 9))
    iconView.image = UIImage(named: imageName)?.withRenderingMode(.alwaysOriginal)
    let iconContainerView = UIView(frame:
                                    CGRect(x: -10, y: 0, width: 30, height: 30))
    iconContainerView.addSubview(iconView)
    rightView = iconContainerView
    rightViewMode = .always
  }

  func addRightButton(withImage image: UIImage?, target: Any?, selector: Selector?) {
    let button = UIButton(type: .custom)
    button.setImage(image, for: .normal)

    guard let selector = selector else { return }
    button.addTarget(target, action: selector, for: .touchUpInside)
    button.frame = CGRect(x: 0, y: 0, width: 30, height: 30)
    button.contentMode = .scaleAspectFit
    self.rightView = button
    self.rightViewMode = .always
  }
}
