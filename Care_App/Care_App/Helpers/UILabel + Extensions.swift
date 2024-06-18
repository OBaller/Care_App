//
//  UILabel + Extensions.swift
//  Care_App
//
//  Created by Naseem Oyebola on 17/06/2024.
//

import UIKit

public extension UILabel {
  convenience init(text: String, size: CGFloat, isBold: Bool) {
    self.init()
    font = isBold ? UIFont(name: "Roboto-Bold", size: 32) : UIFont(name: "Roboto-Bold", size: 16)
    self.text = text
    textColor = K.AppColors.brandGrey
    numberOfLines = 0
    textAlignment = .center
    adjustsFontSizeToFitWidth = true
  }

  convenience init(text: String, size: CGFloat, textColor: UIColor, alignment: NSTextAlignment, isBold: Bool) {
    self.init()
    font = isBold ? UIFont(name: "Roboto-Regular", size: 32) : UIFont(name: "Roboto-Regular", size: 16)
    self.text = text
    numberOfLines = 0
    textAlignment = alignment
    adjustsFontSizeToFitWidth = true
    self.textColor = textColor
  }
  
  convenience init(text: String, size: CGFloat, alignment: NSTextAlignment, isBold: Bool) {
    self.init()
    font = isBold ? UIFont(name: "Roboto-Medium", size: 32) : UIFont(name: "Roboto-Medium", size: 16)
    self.text = text
    numberOfLines = 0
    textAlignment = alignment
    textColor = K.AppColors.brandGrey
    adjustsFontSizeToFitWidth = true
    self.textColor = textColor
  }
  
}

extension UILabel {
  @IBInspectable
  var letterSpace: CGFloat {
    get {
      if let currentLetterSpace = attributedText?.attribute(
        NSAttributedString.Key.kern, at: Int(self.letterSpace), effectiveRange: .none)
          as? CGFloat {
        return currentLetterSpace
      } else {
        return 0
      }
    }

    set {
      let attributedString = NSMutableAttributedString(string: text ?? "")
      attributedString.addAttribute(NSAttributedString.Key.kern, value: newValue, range: NSRange(location: 0, length: attributedString.length))
      attributedText = attributedString
    }
  }
}
