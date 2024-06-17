//
//  VerticalStackView.swift
//  Care_App
//
//  Created by Naseem Oyebola on 17/06/2024.
//

import UIKit

public class VerticalStackView: UIStackView {
    
  override init(frame: CGRect) {
      super.init(frame: frame)
  }
    
  public init(arrangedSubviews: [UIView], spacing: CGFloat) {
      super.init(frame: .zero)

      arrangedSubviews.forEach { addArrangedSubview($0) }
      self.axis = .vertical
      self.spacing = spacing
      isLayoutMarginsRelativeArrangement = true
  }
    
  required init(coder: NSCoder) {
      fatalError("init(coder:) has not been implemented")
  }
}

class HorizontalStack: UIStackView {
  private let stackView = UIStackView()

  override init(frame: CGRect) {
    super.init(frame: frame)
    style()
  }

  init(arrangedSubviews: [UIView], spacing: CGFloat) {
    super.init(frame: .zero)
    addArrangedSubviews(arrangedSubviews)
    self.spacing(spacing)
  }

  required init(coder: NSCoder) {
    fatalError("init(coder:) has not been implemented")
  }

  fileprivate func style() {
    stackView.axis = .horizontal
    stackView.isLayoutMarginsRelativeArrangement = true
    stackView.alignment = .fill
  }
}
// Helpers
extension HorizontalStack {
  func spacing(_ spacing: CGFloat) {
    stackView.spacing = spacing
  }
  func setInsets(_ insets: UIEdgeInsets) {
    stackView.layoutMargins = insets
  }
}

public extension UIStackView {
  func addArrangedSubviews(_ views: [UIView]) {
    views.forEach { addArrangedSubview($0) }
  }
  
  func removeArrangedSubviews(_ views: [UIView]) {
    views.forEach { removeArrangedSubview($0) }
  }
  
  func removeAll() {
    arrangedSubviews.forEach { $0.removeFromSuperview() }
  }

  func containsType<T: UIView>(_ viewType: T.Type) -> Bool {
    for arrangedSubview in arrangedSubviews {
      if arrangedSubview is T {
        return true
      }
    }
    return false
  }

  func noSpacing(after view: UIView? = nil) {
    if let view = view {
      setCustomSpacing(.zero, after: view)
    }
    if let last = subviews.last {
      setCustomSpacing(.zero, after: last)
    }
  }
}
