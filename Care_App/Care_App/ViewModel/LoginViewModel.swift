//
//  LoginViewModel.swift
//  Care_App
//
//  Created by Naseem Oyebola on 18/06/2024.
//

import Foundation

class LoginViewModel {
  var onLoginSuccess: (() -> Void)?
  var onLoginFailure: ((String) -> Void)?
  
  func login(userName: String, password: String) {
    NetworkManager.shared.login(userName: userName, password: password) { [weak self] result in
      switch result {
        case .success(let token):
          UserDefaults.standard.set(token, forKey: "authToken")
          DispatchQueue.main.async {
            self?.onLoginSuccess?()
          }
        case .failure(let error):
          let errorMessage = error.localizedDescription
          DispatchQueue.main.async {
            self?.onLoginFailure?(errorMessage)
          }
      }
    }
  }
}
