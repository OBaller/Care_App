//
//  StaticCheckBoxWith Title.swift
//  Care_App
//
//  Created by Naseem Oyebola on 17/06/2024.
//

import UIKit

class StaticCheckboxWithTitle: UIView {
    var completion: ((Bool) -> Void)?
  let titleLabel = UILabel(text: "", size: 14, textColor: K.AppColors.textSecondary ?? UIColor(), alignment: .left, isBold: false)
    let checkBox = UIButton()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
      setHeight(height: 24)
        setupView()
        setConstraints()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        setupView()
        setConstraints()
    }
    
    func setupView() {
      checkBox.setImage(UIImage(systemName: "square"), for: .normal)
      checkBox.setImage(UIImage(systemName: "checkmark.square.fill"), for: .selected)
      checkBox.addTarget(self, action: #selector(checkBoxPressed), for: .primaryActionTriggered)
        
        titleLabel.numberOfLines = 1
        
        let hStack = UIStackView(arrangedSubviews: [checkBox, titleLabel])
        hStack.spacing = 10
        checkBox.setDimensions(height: 24, width: 24)
        
        addSubview(hStack)
        hStack.newAnchor(left: leftAnchor, paddingLeft: 20)
        hStack.centerYInSuperview()
    }
    
    func setConstraints() {
        // Add any specific constraints if needed
    }
    
    @objc
    func checkBoxPressed() {
        checkBox.isSelected.toggle()
        completion?(checkBox.isSelected)
    }
}
