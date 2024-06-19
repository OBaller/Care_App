//
//  Keychain + Extension.swift
//  Care_App
//
//  Created by Naseem Oyebola on 19/06/2024.
//

import Foundation
import KeychainAccess

class KeychainHelper {
  static let shared = KeychainHelper()
  private let keychain = Keychain(service: "brightSummit.com.Care-App")
  
  private init() {}
  
  func set(_ value: String, forKey key: String) {
    keychain[key] = value
  }
  
  func get(_ key: String) -> String? {
    return keychain[key]
  }
  
  func remove(_ key: String) {
    try? keychain.remove(key)
  }
}
