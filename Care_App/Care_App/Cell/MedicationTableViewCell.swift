//
//  MedicationTableViewCell.swift
//  Care_App
//
//  Created by Naseem Oyebola on 17/06/2024.
//

import UIKit

class MedicationTableViewCell: UITableViewCell {
  var containerView: UIStackView!
  let descriptionLabel = UILabel(text: "", size: 16, alignment: .left, isBold: false)
  let nameLabel = UILabel(text: "", size: 16, alignment: .left, isBold: false)
  let roomLabel = UILabel(text: "", size: 16, alignment: .left, isBold: false)
  let bedLabel = UILabel(text: "", size: 16, alignment: .left, isBold: false)
  let timeLabel = UILabel(text: "", size: 16, alignment: .left, isBold: false)
  
  var descIcon = UIImageView(named: "arrow_icon")
  var nameIcon = UIImageView(named: "user_icon")
  var roomIcon = UIImageView(named: "door_icon")
  var bedIcon = UIImageView(named: "bed_icon")
  var clockIcon = UIImageView(named: "clock_icon")



  override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
    super.init(style: style, reuseIdentifier: reuseIdentifier)
    setupView()
  }

  required init?(coder: NSCoder) {
    fatalError("init(coder:) has not been implemented")
  }
  
  private func setupView() {
    descIcon.setDimensions(height: 25, width: 25)
    nameIcon.setDimensions(height: 20, width: 20)
    roomIcon.setDimensions(height: 20, width: 20)
    bedIcon.setDimensions(height: 20, width: 20)
    clockIcon.setDimensions(height: 20, width: 20)

    containerView = UIStackView()
    containerView.clipsToBounds = true
    containerView.cornerRadius = 7
    containerView.isLayoutMarginsRelativeArrangement = true
    containerView.layoutMargins = .init(top: 10, left: 10, bottom: 12, right: 10)
    containerView.backgroundColor = K.AppColors.cellBg
    containerView.axis = .vertical
    containerView.setHeight(height: 100)
    let contentStack = VerticalStackView(arrangedSubviews: [containerView, UIView(height: 16, bgColor: .white, cornerRadius: nil)], spacing: 0)
    contentView.addSubview(contentStack)
    contentStack.fillSuperview()
    
    let topStack = HorizontalStack(arrangedSubviews: [descriptionLabel, descIcon])
    let middleStack = HorizontalStack(arrangedSubviews: [nameIcon, nameLabel])
    let bottmStack = HorizontalStack(arrangedSubviews: [roomIcon, roomLabel, bedIcon, bedLabel, clockIcon, timeLabel])
    containerView.addArrangedSubviews([topStack, middleStack, bottmStack])
    containerView.setCustomSpacing(6, after: middleStack)
  }
  
  func configure(with model: MedsModel) {
    descriptionLabel.text = model.description
    nameLabel.text = model.name
    roomLabel.text = model.room
    bedLabel.text = model.bed
    timeLabel.text = model.time
  }

}
