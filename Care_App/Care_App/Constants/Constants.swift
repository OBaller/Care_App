//
//  Constants.swift
//  Care_App
//
//  Created by Naseem Oyebola on 17/06/2024.
//

import UIKit

public typealias K = Constants

public enum Constants {
  public enum Images {
    static let logo = UIImage(named: "logo")
    static let checkMark = UIImage(named: "checkMark")
    static let errorIcon = UIImage(named: "errorIcon")
    static let reveal = UIImage(named: "reveal")
    static let conceal = UIImage(named: "conceal")
    static let bellIcon = UIImage(named: "bell_icon")
  }
  
  public enum AppColors {
    static let primarybg =  UIColor(named: "primarybg")
    static let buttonYellow = UIColor(named: "button_yellow")
    static let buttonRed = UIColor(named: "button_red")
    static let brandGrey = UIColor(named: "brand_grey")
    static let textPrimary = UIColor(named: "text_primary")
    static let textSecondary = UIColor(named: "text_secondary")
    static let cellBg = UIColor(named: "cellBg")
  }
  
  public enum LoginVCStrings {
    static let errorMessage = "Password must contain letters, numbers and special characters"
  }
  
  public enum ValidationStrings {
      static let nameText = "[A-Z0-9a-z]([A-Z0-9a-z._%+-]{0,30}[A-Z0-9a-z])?"
      static let serverText = "([A-Z0-9a-z]([A-Z0-9a-z-]{0,30}[A-Z0-9a-z])?\\.){1,5}"
      static let at = "@"
      static let aToZ1To8 = "[A-Za-z]{2,8}"
      static let nsPredicate = "SELF MATCHES %@"
      static let numberRegEx = ".*[0-9]+.*"
      static let specialCharacterRegEx = ".*[.!&^%$#@()/]+.*"
      static let capitalLetterRegEx = ".*[A-Z]+.*"
      static let emailRegex = "[A-Z0-9a-z]([A-Z0-9a-z._%+-]{0,30}[A-Z0-9a-z])?@([A-Z0-9a-z]([A-Z0-9a-z-]{0,30}[A-Z0-9a-z])?\\.){1,5}[A-Za-z]{2,8}"
    public static let signUpEmailExistsError = "Email has been registered already. Kindly"
    public static let loginInvalidEmailError = "Email is incorrect, check and try again"
    public static let loginInvalidPasswordError = "Password is incorrect, check and try again"
  }
}
