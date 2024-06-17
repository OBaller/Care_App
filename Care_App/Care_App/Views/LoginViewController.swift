// LoginViewController.swift
// Care_App
 //
// Created by Naseem Oyebola on 17/06/2024.
//

import UIKit

class LoginViewController: UIViewController {
  var isCheckboxChecked = false
  let titleLabel = UILabel(text: "Welcome back 👋🏼", size: 32, isBold: true)
  let subtitleLabel = UILabel(text: "Fill your details to get started", size: 16, textColor: K.AppColors.brandGrey ?? UIColor(), alignment: .left, isBold: false)
  lazy var checks: StaticCheckboxWithTitle = {
      let check = StaticCheckboxWithTitle()
      check.titleLabel.text = "Remember me"
      check.completion = { isChecked in
          self.isCheckboxChecked = isChecked
      }
      return check
  }()
  let forgotLabel = UILabel(text: "Forgot Password?", size: 16, textColor: K.AppColors.buttonred ?? UIColor(), alignment: .right, isBold: false)
  
  public lazy var emailField: CAEmailField = {
    let textField = CAEmailField("Username")
    textField.becomeFirstResponder()
    textField.isEmailCompletion = { email in
//      self.delegate?.checkEmailUniqueness(email: email)
    }
    return textField
  }()
  
  public lazy var passwordField: CAPasswordField = {
    let textField = CAPasswordField("Password")
//    textField.addTarget(self, action: #selector(passwordValidationViews), for: .editingChanged)
    textField.addTogglePassword()
    return textField
  }()
  
  lazy var loginButton = UIButton.createButtonWithPrimaryBackground(withText: "Sign in")

  public lazy var dontHaveAccountView = FooterLabelPrimaryButtonTextView(labelText: "Don't have an account?", buttonTitle: "Contact Support", hasBoldButtonText: true) {
    self.didTapSupport()
  }

  
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
      setUpViews()
  
    }
  
  private func setUpViews() {
    let headerStack = VerticalStackView(arrangedSubviews: [titleLabel, subtitleLabel], spacing: 8)
    view.addSubview(headerStack)
    headerStack.newAnchor(top: view.safeAreaLayoutGuide.topAnchor, left: view.leftAnchor, paddingTop: 180, paddingLeft: 20)
    let forgotStack = HorizontalStack(arrangedSubviews: [checks, UIView(), forgotLabel])
    forgotStack.axis = .horizontal
    let overallStack = VerticalStackView(arrangedSubviews: [emailField, passwordField, forgotStack, loginButton], spacing: 25)
    view.addSubview(overallStack)
    overallStack.newAnchor(top: headerStack.bottomAnchor, left: view.leftAnchor, right: view.rightAnchor, paddingTop: 50, paddingLeft: 20, paddingRight: 20)
    let supportStack = VerticalStackView(arrangedSubviews: [dontHaveAccountView])
    supportStack.alignment = .center
    view.addSubview(supportStack)
    supportStack.newAnchor(top: overallStack.bottomAnchor, left: view.leftAnchor, right: view.rightAnchor, paddingTop: 25, paddingLeft: 20, paddingRight: 20)
    loginButton.addTarget(self, action: #selector(handleLoginButtonTapped), for: .touchUpInside)
    
  }
    
    @objc 
    func handleLoginButtonTapped() {
        let tabBarController = TabBarController()
        tabBarController.modalPresentationStyle = .fullScreen
        present(tabBarController, animated: true, completion: nil)
    }
  
  @objc
  func didTapSupport() {
    print("clickacbel")
  }
  
}
