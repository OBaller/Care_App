//
//  CustomTextField.swift
//  Care_App
//
//  Created by Naseem Oyebola on 17/06/2024.
//

import UIKit

public class CustomTextfield: UITextField {
  
  override public init(frame: CGRect) {
    super.init(frame: frame)
    delegate = self
    setHeight(height: 46)
    layer.borderColor = K.AppColors.brandGrey?.cgColor
  }

  required init?(coder: NSCoder) {
    fatalError("init(coder:) has not been implemented")
  }

  
  private func createButtonImageView(buttonImage: UIImage) -> UIButton {
    let button = UIButton(type: .system)
    button.backgroundColor = K.AppColors.primarybg
    button.setDimensions(height: 55, width: 80)
    button.setImage(buttonImage, for: .normal)
    button.imageView?.setDimensions(height: 7, width: 12)
    return button
  }

  func addRightImage(named imageName: String, size: CGSize) {
    let view = UIView(frame: CGRect(x: frame.width - size.width - 8, y: 0, width: size.width + 8, height: 30))
    let imageView = UIImageView(image: UIImage(named: imageName))
    imageView.contentMode = .scaleAspectFit
    imageView.frame = CGRect(x: 0, y: (30 - size.height) / 2, width: size.width, height: size.height)
    view.addSubview(imageView)
    rightView = view
    rightViewMode = .always
  }
  
  @objc
  func buttonPressed() {
    self.becomeFirstResponder()
  }
}

extension CustomTextfield: UITextFieldDelegate {
  public func textFieldDidBeginEditing(_ textField: UITextField) {
    textField.layer.borderWidth = 1
    textField.layer.borderColor = K.AppColors.brandGrey?.cgColor
  }

  public func textFieldDidEndEditing(_ textField: UITextField) {
    textField.layer.borderWidth = 1
  }
}
