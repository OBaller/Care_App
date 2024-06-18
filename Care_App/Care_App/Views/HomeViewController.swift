//
//  ViewController.swift
//  Care_App
//
//  Created by Naseem Oyebola on 17/06/2024.
//

import UIKit

class HomeViewController: UIViewController {
  let viewModel = HomeScreenViewModel()
  let titleLabel = UILabel(text: "Hi, George!", size: 18, isBold: false)
  let subtitleLabel = UILabel(text: "Clock-in to begin your task", size: 16, textColor: K.AppColors.brandGrey ?? UIColor(), alignment: .left, isBold: false)

  var notificationIcon = UIImageView(named: "bell_icon")
  lazy var clockInButton = UIButton.createButtonWithPrimaryBackground(withText: "Clock-in")
  lazy var breakButton = UIButton.createButtonWithPrimaryBackground(withText: "Take a break")
  lazy var clockOutButton = UIButton.createButtonWithPrimaryBackground(withText: "Clock-out")
  
  public var tableView: UITableView = {
    let tableView = UITableView(frame: .zero, style: .plain)
    tableView.separatorStyle = .none
    tableView.estimatedRowHeight = 200
    tableView.rowHeight = UITableView.automaticDimension
    tableView.showsVerticalScrollIndicator = false
    return tableView
  }()
  
  override func viewDidLoad() {
    super.viewDidLoad()
    view.backgroundColor = .white
    tableView.delegate = self
    tableView.dataSource = self
    tableView.register(MedicationTableViewCell.self)

    setupViews()
//    clockInButton.hide()
  }

  private func setupViews() {
    breakButton.backgroundColor = K.AppColors.buttonYellow
    clockOutButton.backgroundColor = K.AppColors.buttonred
    clockInButton.addTarget(self, action: #selector(didTapClockin), for: .touchUpInside)
    notificationIcon.setDimensions(height: 32, width: 32)
    let headerStack = VerticalStackView(arrangedSubviews: [titleLabel, subtitleLabel], spacing: 8)
    headerStack.alignment = .leading
    view.addSubview(headerStack)
    headerStack.newAnchor(top: view.safeAreaLayoutGuide.topAnchor, left: view.leftAnchor, paddingTop: 20, paddingLeft: 20)
    view.addSubview(notificationIcon)
    notificationIcon.newAnchor(top: view.safeAreaLayoutGuide.topAnchor, right: view.rightAnchor, paddingTop: 25, paddingRight: 20)
    view.addSubview(clockInButton)
    clockInButton.newAnchor(top: headerStack.bottomAnchor, left: view.leftAnchor, right: view.rightAnchor, paddingTop: 25, paddingLeft: 20, paddingRight: 20)

    let spaceView = UIView()
    spaceView.setDimensions(height: 36, width: 20)
    let buttonStack = HorizontalStack(arrangedSubviews: [breakButton, spaceView, clockOutButton], spacing: 20)
    buttonStack.distribution = .fillProportionally
        view.addSubview(buttonStack)
        buttonStack.newAnchor(top: clockInButton.bottomAnchor, left: view.leftAnchor, right: view.rightAnchor, paddingTop: 25, paddingLeft: 20, paddingRight: 20)
    
    view.addSubview(tableView)
    tableView.newAnchor(top: buttonStack.bottomAnchor, left: view.leftAnchor, bottom: view.bottomAnchor, right: view.rightAnchor)
  }
  
  // MARK: - Actions
  @objc func didTapClockin() {
    
  }

}

extension HomeViewController: UITableViewDelegate, UITableViewDataSource {

  public func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
    return viewModel.medications.count
  }
  
  public func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
    let cell = tableView.dequeue(MedicationTableViewCell.self, indexPath)
    let meds = viewModel.medications[indexPath.row]
    cell.configure(with: meds)
    return cell
  }
}
