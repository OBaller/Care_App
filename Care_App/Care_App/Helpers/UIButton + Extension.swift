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
//      titleLabel?.font = .BBG.paragraphSmall.font
    setTitleColor(textColor, for: .normal)
    setHeight(height: 40)
    backgroundColor = bgColor
  }
  
  static func createButtonWithPrimaryBackground(withText text: String) -> UIButton {
    let buttton = UIButton(text: text, textColor: .white, bgColor: K.AppColors.primarybg)
    buttton.layer.cornerRadius = 4
    return buttton
  }
}
