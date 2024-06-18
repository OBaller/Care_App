//
//  UIButton + Extension.swift
//  Care_App
//
//  Created by Naseem Oyebola on 17/06/2024.
//

import UIKit

public extension UIButton {
  convenience init(text: String, textColor: UIColor? = nil, bgColor: UIColor? = nil) {
    self.init(type: .custom)
    setTitle(text, for: .normal)
    titleLabel?.text = text
    titleLabel?.font = UIFont(name: "Roboto-Regular", size: 14)
    setTitleColor(textColor, for: .normal)
    setHeight(height: 40)
    backgroundColor = bgColor
  }
  
  static func createButtonWithPrimaryBackground(withText text: String) -> UIButton {
    let buttton = UIButton(text: text, textColor: .white, bgColor: K.AppColors.primarybg)
    buttton.layer.cornerRadius = 4
    return buttton
  }
  
  static func createDontHaveAccountButton() -> UIButton {
    let button = UIButton(text: "", textColor: K.AppColors.primarybg, bgColor: nil)
    button.setAttributedTitle(NSAttributedString.customAttributedRegularAndMediumUnderlined(
      string1: "Don't have an account? Contact Support", inRange: "Contact Support"), for: .normal)
    return button
  }
  
  static func createButtonWithPrimaryText(_ text: String, textColor: UIColor) -> UIButton {
    return UIButton(text: text, textColor: textColor, bgColor: nil)
  }
  
  func disable() {
    self.isEnabled = false
    self.backgroundColor = K.AppColors.textSecondary
    self.setTitleColor(.white.withAlphaComponent(0.6), for: .disabled)
  }

  func enable() {
    self.isEnabled = true
    self.backgroundColor = K.AppColors.primarybg
  }
  
}
