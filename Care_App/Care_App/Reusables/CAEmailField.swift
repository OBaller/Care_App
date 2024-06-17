//
//  CAEmailField.swift
//  Care_App
//
//  Created by Naseem Oyebola on 17/06/2024.
//

import UIKit

public class CAEmailField: CustomTextfield {
  var isEmailCompletion: ((String) -> Void)?
  var tapCompletion: (() -> Void)?

  private var checkerView: UIView!

  var emailExists: Bool? {
    didSet {
      if emailExists == true {
        handleEmailExistsError()
      } else {
        emailErrorLabel.isHidden = true
      }
    }
  }
  
  var invitedUserEmailExists: Bool? {
    didSet {
      if invitedUserEmailExists == true {
        handleUserManagementEmailExistsError()
      } else {
        emailErrorLabel.isHidden = true
      }
    }
  }

  var userExists: Bool? {
    didSet {
      if userExists == false {
        handleUserExistsError()
      } else {
        configureValidInput()
      }
    }
  }

  override public init(frame: CGRect) {
    super.init(frame: frame)
    addTarget(self, action: #selector(editingDidBegin), for: .editingChanged)
    setupView()
  }

  fileprivate func setupEmailChecker() {
    checkerView = UIView()
    checkerView.setDimensions(height: 55, width: 50)
    checkerView.addSubview(checkmark)
    checkmark.newAnchor(left: checkerView.leftAnchor)
    checkmark.centerInSuperview()
  }

  func addEmailChecker() {
    rightView = checkerView
    rightViewMode = .whileEditing
  }

  func removeRightView() {
    rightView = .none
  }

  private func setupView() {
    setupEmailChecker()
    addSubview(emailErrorLabel)
    emailErrorLabel.newAnchor(top: bottomAnchor, left: leftAnchor, right: rightAnchor, paddingTop: 5)
  }

  let checkmark: UIImageView = {
    let image = UIImageView(frame: CGRect(x: 0, y: 0, width: 20, height: 20))
    image.image = Constants.Images.checkMark
    image.contentMode = .scaleAspectFit
    image.translatesAutoresizingMaskIntoConstraints = false
    image.isHidden = true
    return image
  }()

  lazy var emailErrorLabel = FooterLabelPrimaryButtonTextView(completion: tapCompletion)

  required init?(coder: NSCoder) {
    fatalError("init(coder:) has not been implemented")
  }

  fileprivate func validateEmail(email: String) {
    let emailRegex = Constants.ValidationStrings.emailRegex
    let emailPredicate = NSPredicate(format: Constants.ValidationStrings.nsPredicate, emailRegex)
    let emailResult = emailPredicate.evaluate(with: email)
    if email.isEmpty {
      layer.borderColor = K.AppColors.primarybg?.cgColor
      checkmark.isHidden = true
      emailErrorLabel.isHidden = true
    } else if emailResult {
      isEmailCompletion?(email)
      layer.borderColor = K.AppColors.primarybg?.cgColor
      checkmark.image = Constants.Images.checkMark
      checkmark.isHidden = false
      emailErrorLabel.isHidden = true
    } else {
      configureInputErrorView()
      setEmailErrorLabelPropertyOnInvalidEmail()
    }
  }

  fileprivate func validateIfUserExists(email: String) {
    let emailRegex = K.ValidationStrings.emailRegex
    let emailPredicate = NSPredicate(format: Constants.ValidationStrings.nsPredicate, emailRegex)
    let emailResult = emailPredicate.evaluate(with: email)
    if emailResult {
      isEmailCompletion?(email)
    }
  }

  //
  fileprivate func setCheckMarkInvalidEmail() {
    checkmark.isHidden = false
    checkmark.image = Constants.Images.errorIcon
  }

  fileprivate func configureInputErrorView() {
    borderColor = K.AppColors.buttonred
    setCheckMarkInvalidEmail()
  }

  fileprivate func configureValidInput() {
    borderColor = K.AppColors.primarybg
    checkmark.image = Constants.Images.checkMark
    emailErrorLabel.hide()
  }

  //
  fileprivate func handleEmailExistsError() {
    emailErrorLabel.setLabelColor(color: K.AppColors.buttonred!)
    emailErrorLabel.configureLabel(labelText: "Email has been registered already. Kindly",
                                   buttonTitle: "Sign in",
                                   hasBoldButtonText: true)
    emailErrorLabel.isHidden = false
    configureInputErrorView()
  }
  
  fileprivate func handleUserManagementEmailExistsError() {
    emailErrorLabel.setLabelColor(color: K.AppColors.buttonred!)
    emailErrorLabel.configureLabel(labelText: "Email has been registered already.")
    emailErrorLabel.isHidden = false
    configureInputErrorView()
  }

  fileprivate func handleUserExistsError() {
    emailErrorLabel.setLabelColor(color: K.AppColors.buttonred!)
    emailErrorLabel.configureLabel(labelText: "Email is incorrect, check and try again")
    emailErrorLabel.isHidden = false
    borderColor = K.AppColors.buttonred
  }

  fileprivate func setEmailErrorLabelPropertyOnInvalidEmail() {
    emailErrorLabel.configureLabel(labelText: "Please enter a valid email")
    emailErrorLabel.setLabelColor(color: K.AppColors.buttonred!)
    emailErrorLabel.isHidden = false
  }

  @objc
  func editingDidBegin(_ textField: UITextField) {
    guard let emailText = textField.text else { return }
    validateEmail(email: emailText)
  }
}

