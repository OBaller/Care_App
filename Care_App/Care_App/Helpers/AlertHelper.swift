//
//  AlertHelper.swift
//  Care_App
//
//  Created by Naseem Oyebola on 18/06/2024.
//

import UIKit

public enum AlertHelper {
  public static func popUpAlert(title: String, message: String, self: UIViewController) {
    let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)
    alert.addAction(UIAlertAction(title: "Ok", style: .cancel, handler: nil))
    self.present(alert, animated: true)
  }

  public static func popUpAlert(title: String, message: String, self: UIViewController, completion: (() -> Void)? ) {
    let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)
    self.present(alert, animated: true)
    completion?()
  }

  public static func popUpAlert(title: String = "", message: String, preferredStyle: UIAlertController.Style = .alert, actionText: String = "OK", vc: UIViewController, handlerAction: ((UIAlertAction) -> Void)? = nil) {
    let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)
    alert.addAction(UIAlertAction(
      title: NSLocalizedString(actionText, comment: ""),
      style: .default,
      handler: (handlerAction)))
    vc.present(alert, animated: true)
  }

  public static func dismissAndPresentAlert(message: String, title: String? = nil, viewController: UIViewController) {
    DispatchQueue.main.async {
      viewController.dismiss(animated: true) {
        AlertHelper.popUpAlert(title: title ?? "", message: message, self: viewController)
      }
    }
  }
}
