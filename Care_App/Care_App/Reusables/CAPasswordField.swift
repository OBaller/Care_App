//
//  CAPasswordField.swift
//  Care_App
//
//  Created by Naseem Oyebola on 17/06/2024.
//

import UIKit

public class CAPasswordField: CustomTextfield {
  let eyeBtn = UIButton(type: .custom)

  let errorLabel = UILabel(text: "Constants.LoginVCStrings.errorMessage", size: 14, textColor: K.AppColors.buttonred ?? UIColor(), alignment: .left, isBold: false)
  
  func addErrorLabel() {
    addSubview(errorLabel)
    errorLabel.newAnchor(top: bottomAnchor, left: leftAnchor, paddingTop: 5)
    cornerRadius = 8
    errorLabel.hide()
  }
  
  private let eyeButtonImages = [
    Constants.Images.reveal,
    Constants.Images.conceal
  ]
  
  func addTogglePassword() {
    let button = UIButton(type: .custom)
    button.addTarget(self, action: #selector(handlePasswordToggle), for: .primaryActionTriggered)
    button.setDimensions(height: 55, width: 50)
    button.imageView?.contentMode = .scaleAspectFit
    button.setImage(eyeButtonImages[1], for: .normal)
    rightView = button
    rightViewMode = .always
    isSecureTextEntry = true
  }

  @objc
  func handlePasswordToggle(_ sender: UIButton) {
    guard let image = self.isSecureTextEntry ? eyeButtonImages[0] : eyeButtonImages[1] else { return }
    self.isSecureTextEntry.toggle()
    sender.setImage(image, for: .normal)
    sender.imageView?.setDimensions(height: 20, width: 20)
  }

  @objc
  func passwordValidationViews(_ textField: UITextField) {
    guard let passwordText = self.text else { return }
    if passwordText.isValidPassword {
      errorLabel.hide()
      borderColor = K.AppColors.brandGrey
      backgroundColor = .white
    } else {
      errorLabel.show()
      borderWidth = 1
      borderColor = K.AppColors.buttonred
    }
    errorLabel.isHidden = passwordText.isEmpty
  }
}
