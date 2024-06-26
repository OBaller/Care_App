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
  
  lazy var forgotButton = UIButton.createButtonWithPrimaryText("Forgot Password?", textColor: K.AppColors.buttonRed ?? UIColor())
  
  public lazy var userNameField: CustomTextfield = {
    let textField = CustomTextfield("Username")
    textField.becomeFirstResponder()
    return textField
  }()
  
  public lazy var passwordField: CAPasswordField = {
    let textField = CAPasswordField("Password")
    textField.addTarget(self, action: #selector(passwordValidationViews), for: .editingChanged)
    textField.addTogglePassword()
    return textField
  }()
  
  public let errorLabel: UILabel = {
    let label = UILabel()
    label.text = "Password must contain letters, numbers and special characters"
    label.textColor = K.AppColors.buttonRed
    label.numberOfLines = 2
    label.font = UIFont(name: "Roboto-Light", size: 13)
    label.isHidden = true
    return label
  }()
  
  lazy var loginButton = UIButton.createButtonWithPrimaryBackground(withText: "Sign in")
  
  lazy var dontHaveAccButton: UIButton = {
    let button = UIButton.createDontHaveAccountButton()
    button.addTarget(self, action: #selector(didTapSupport), for: .touchUpInside)
    return button
  }()
  
  let footerLabel = UILabel()

  let viewModel = LoginViewModel()
  let activityIndicator = UIActivityIndicatorView(style: .large)
  
  override func viewDidLoad() {
    super.viewDidLoad()
    view.backgroundColor = .white
    setUpViews()
    loginButton.disable()
    userNameField.addTarget(self, action: #selector(textFieldsDidChange), for: .editingChanged)
    passwordField.addTarget(self, action: #selector(textFieldsDidChange), for: .editingChanged)
    
    viewModel.onLoginSuccess = { [weak self] in
      self?.activityIndicator.stopAnimating()
      let tabBarController = TabBarController()
      tabBarController.modalPresentationStyle = .fullScreen
      self?.present(tabBarController, animated: true, completion: nil)
    }
    
    viewModel.onLoginFailure = { [weak self] errorMessage in
      self?.activityIndicator.stopAnimating()
      AlertHelper.popUpAlert(title: "Login Failed", message: errorMessage, self: self ?? UIViewController())
    }
  }
  
  private func setUpViews() {
    let headerStack = VerticalStackView(arrangedSubviews: [titleLabel, subtitleLabel], spacing: 8)
    headerStack.alignment = .leading
    view.addSubview(headerStack)
    headerStack.newAnchor(top: view.safeAreaLayoutGuide.topAnchor, left: view.leftAnchor, paddingTop: 180, paddingLeft: 20)
    
    let forgotStack = HorizontalStack(arrangedSubviews: [checks, UIView(), forgotButton])
    forgotStack.axis = .horizontal
    
    let overallStack = VerticalStackView(arrangedSubviews: [userNameField, passwordField, errorLabel, forgotStack, loginButton], spacing: 25)
    overallStack.setCustomSpacing(8, after: passwordField)
    view.addSubview(overallStack)
    overallStack.newAnchor(top: headerStack.bottomAnchor, left: view.leftAnchor, right: view.rightAnchor, paddingTop: 50, paddingLeft: 20, paddingRight: 20)
    
    let supportStack = VerticalStackView(arrangedSubviews: [dontHaveAccButton])
    supportStack.alignment = .center
    view.addSubview(supportStack)
    supportStack.newAnchor(top: overallStack.bottomAnchor, left: view.leftAnchor, right: view.rightAnchor, paddingTop: 25, paddingLeft: 20, paddingRight: 20)
    
    view.addSubview(activityIndicator)
    activityIndicator.center = view.center
    
    view.addSubview(footerLabel)
    footerLabel.newAnchor(left: view.leftAnchor, bottom: view.safeAreaLayoutGuide.bottomAnchor, right: view.rightAnchor, paddingLeft: 20, paddingBottom: 10, paddingRight: 20)
    
    loginButton.addTarget(self, action: #selector(handleLoginButtonTapped), for: .touchUpInside)
    setUpFooterLabel()
  }
  
  private func setUpFooterLabel() {
    footerLabel.numberOfLines = 0
    footerLabel.textAlignment = .center
    let termsString = "Terms & Conditions"
    let privacyString = "Privacy Policy"
    let fullString = "By clicking 'Sign in' above you agree to Arocare’s \(termsString) and \(privacyString)."
    
    let attributedString = NSMutableAttributedString(string: fullString)
    let termsRange = (fullString as NSString).range(of: termsString)
    let privacyRange = (fullString as NSString).range(of: privacyString)
    let tint = K.AppColors.primarybg
    attributedString.addAttribute(.foregroundColor, value: tint as Any, range: termsRange)
    attributedString.addAttribute(.foregroundColor, value: tint as Any, range: privacyRange)
    attributedString.addAttribute(.link, value: "terms://", range: termsRange)
    attributedString.addAttribute(.link, value: "privacy://", range: privacyRange)
    
    footerLabel.attributedText = attributedString
    footerLabel.isUserInteractionEnabled = true
    let tapGesture = UITapGestureRecognizer(target: self, action: #selector(handleTapOnLabel(_:)))
    footerLabel.addGestureRecognizer(tapGesture)
    footerLabel.font = UIFont(name: "Roboto-Regular", size: 13)
    footerLabel.textColor = K.AppColors.brandGrey
  }
  
  
  // MARK: - Actions
  @objc
  func handleLoginButtonTapped() {
    guard let userName = userNameField.text, !userName.isEmpty,
          let password = passwordField.text, !password.isEmpty else {
      return
    }
    activityIndicator.startAnimating()
    viewModel.login(userName: userName, password: password)
  }
  
  @objc
  func didTapSupport() {
    print("clickacbel")
  }
  
  @objc
  func textFieldsDidChange() {
    let isUsernameNotEmpty = !(userNameField.text?.isEmpty ?? true)
    let isPasswordValid = validatePasswordComponents()
    
    if isUsernameNotEmpty && isPasswordValid {
      loginButton.enable()
    } else {
      loginButton.disable()
    }
  }
  
  @objc
  func handleTapOnLabel(_ gesture: UITapGestureRecognizer) {
    guard let label = gesture.view as? UILabel else { return }
    
    let termsString = "Terms & Conditions"
    let privacyString = "Privacy Policy"
    let fullString = label.text ?? ""
    
    let termsRange = (fullString as NSString).range(of: termsString)
    let privacyRange = (fullString as NSString).range(of: privacyString)
    
    let tapLocation = gesture.location(in: label)
    let tapIndex = indexOfAttributedTextCharacterAtPoint(point: tapLocation, label: label)
    
    if NSLocationInRange(tapIndex, termsRange) {
      print("Terms & Conditions tapped")
    } else if NSLocationInRange(tapIndex, privacyRange) {
      print("Privacy Policy tapped")
    }
  }
  
  func indexOfAttributedTextCharacterAtPoint(point: CGPoint, label: UILabel) -> Int {
    guard let attributedText = label.attributedText else { return NSNotFound }
    
    let textStorage = NSTextStorage(attributedString: attributedText)
    let layoutManager = NSLayoutManager()
    textStorage.addLayoutManager(layoutManager)
    
    let textContainer = NSTextContainer(size: label.bounds.size)
    textContainer.lineFragmentPadding = 0.0
    textContainer.maximumNumberOfLines = label.numberOfLines
    textContainer.lineBreakMode = label.lineBreakMode
    layoutManager.addTextContainer(textContainer)
    
    let glyphIndex = layoutManager.glyphIndex(for: point, in: textContainer)
    return layoutManager.characterIndexForGlyph(at: glyphIndex)
  }
}

extension LoginViewController {
  @objc
  func passwordValidationViews(_ textField: UITextField) {
    guard let passwordText = passwordField.text else { return }
    DispatchQueue.main.async { [weak self] in
      guard let self = self else { return }
      self.passwordTextBoxValidation()
      if passwordText.isEmpty {
        self.errorLabel.isHidden = true
      }
      self.textFieldsDidChange()
    }
  }
  
  func passwordTextBoxValidation() {
    if validatePasswordComponents() == true {
      passwordField.layer.borderColor = K.AppColors.brandGrey?.cgColor
      errorLabel.isHidden = true
    } else {
      passwordField.layer.borderColor = K.AppColors.buttonRed?.cgColor
      errorLabel.isHidden = false
    }
  }
  
  func validatePasswordComponents() -> Bool {
    guard let passwordText = passwordField.text else { return false }
    var lengthValidation = false
    var numberValidation = false
    var specialCharValidation = false
    var uppercaseValidation = false
    var answer = false
    // At least 8 characters
    if passwordText.count >= 8 {
      lengthValidation = true
    }
    // At least one digit
    let numberRegEx  = Constants.ValidationStrings.numberRegEx
    let numberTextTest = NSPredicate(format: Constants.ValidationStrings.nsPredicate, numberRegEx)
    let numberResult = numberTextTest.evaluate(with: passwordText)
    if numberResult == true {
      numberValidation = true
    }
    // At least one special character
    let specialCharacterRegEx  = Constants.ValidationStrings.specialCharacterRegEx
    let specCharTextTest = NSPredicate(format: Constants.ValidationStrings.nsPredicate, specialCharacterRegEx)
    let specialCharacterResult = specCharTextTest.evaluate(with: passwordText)
    if specialCharacterResult == true {
      specialCharValidation = true
    }
    // At least one capital letter
    let capitalLetterRegEx  = Constants.ValidationStrings.capitalLetterRegEx
    let capitalTest = NSPredicate(format: Constants.ValidationStrings.nsPredicate, capitalLetterRegEx)
    let upperCaseResult = capitalTest.evaluate(with: passwordText)
    if upperCaseResult == true {
      uppercaseValidation = true
    }
    // Confirm password pattern is passed
    answer = lengthValidation && numberValidation  && specialCharValidation && uppercaseValidation
    return answer
  }
}
