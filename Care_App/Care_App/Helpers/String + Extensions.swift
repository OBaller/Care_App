//
//  String + Extensions.swift
//  Care_App
//
//  Created by Naseem Oyebola on 17/06/2024.
//

import UIKit

public extension String {
  func replaceCharacters(inRange range: Range<Int>, with characterToReplace: Character) -> Self {
    return String(self.enumerated().map { !(range).contains($0) ? $1 : characterToReplace })
  }
  
  func underline() -> NSAttributedString {
    return NSAttributedString(string: self, attributes: [.underlineStyle: NSUnderlineStyle.single.rawValue])
  }
  
  func underlineButtonTitle() -> String {
    let underlineAttribute = NSAttributedString(string: self, attributes: [.underlineStyle: NSUnderlineStyle.single.rawValue])
    return underlineAttribute.string
  }
  
  func isValidPhoneNumber() -> Bool {
    let regexPattern = "^(\\+?234|0)?[789]\\d{9}$"
    guard let regex = try? NSRegularExpression(pattern: regexPattern) else { return false }
    let range = NSRange(location: 0, length: self.utf16.count)
    return regex.firstMatch(in: self, options: [], range: range) != nil
  }
  
  var isValidEmail: Bool {
    let emailRegex = Constants.ValidationStrings.emailRegex
    let emailPredicate = NSPredicate(format: Constants.ValidationStrings.nsPredicate, emailRegex)
    return emailPredicate.evaluate(with: self)
  }
  
  var isValidPassword: Bool {
    let passRegEx = "^(?=.*[$@$#!%*?&])(?=.*[A-Z])(?=.*[0-9]).{8,}$"
    let passwordTest = NSPredicate(format:"SELF MATCHES %@", passRegEx)
    return passwordTest.evaluate(with: self)
  }
  
  var hasSpecialCharacter: Bool {
    let specialCharacterSet = CharacterSet(charactersIn: "!@#$%^&*()_+-=")
    return self.rangeOfCharacter(from: specialCharacterSet) != nil
  }
  
  var isValidAccountNumber: Bool {
    let digitCharacterSet = CharacterSet.decimalDigits
    let lengthIsCorrect = self.count == 10
    let containsOnlyDigits = self.rangeOfCharacter(from: digitCharacterSet.inverted) == nil
    return lengthIsCorrect && containsOnlyDigits
  }
  
  func asteriskName() -> String {
    guard count > 2 else {
      return self
    }
    var result = String()
    let name = components(separatedBy: " ")
    for (index, text) in name.enumerated() {
      let firstTwoChars = String(text.prefix(2))
      let remainingChars = String(text.suffix(text.count - 2))
      let asterisks = String(repeating: "*", count: remainingChars.count)
      let res = firstTwoChars + asterisks
      if index == 1 {
        result.append(" ")
      }
      result.append(res)
    }
    return result
  }
}

public extension NSAttributedString {
  class func customAttributedRegularAndMediumUnderlined(string1: String, inRange string2: String) -> NSAttributedString {
    let underlineAttriString = NSMutableAttributedString(string: string1)
    var font: UIFont = UIFont.systemFont(ofSize: 14)
    let range1 = (string1 as NSString).range(of: string2)
    underlineAttriString.addAttribute(NSAttributedString.Key.underlineStyle, value: NSUnderlineStyle.single.rawValue, range: range1)
    underlineAttriString.addAttribute(NSAttributedString.Key.font, value: font, range: range1)
    underlineAttriString.addAttribute(NSAttributedString.Key.foregroundColor, value: K.AppColors.primarybg!, range: range1)
    return underlineAttriString
  }
}
