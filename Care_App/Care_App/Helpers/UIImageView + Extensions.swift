//
//  UIImageView + Extensions.swift
//  Care_App
//
//  Created by Naseem Oyebola on 17/06/2024.
//

import UIKit

public extension UIImageView {
  convenience init(named imageName: String) {
    self.init()
    image = UIImage(named: imageName)?.withRenderingMode(.alwaysOriginal)
    clipsToBounds = true
    contentMode = .scaleAspectFit
    translatesAutoresizingMaskIntoConstraints = false
  }
  
  static func custom() -> UIImageView {
    let iv = UIImageView()
    iv.clipsToBounds = true
    iv.contentMode = .scaleAspectFit
    iv.translatesAutoresizingMaskIntoConstraints = false
    return iv
  }
}

