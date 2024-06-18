// HomeViewController.swift
// Care_App
//
// Created by Naseem Oyebola on 17/06/2024.
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
  
  lazy var medicationButton: UIButton = {
    let button = UIButton(type: .system)
    button.setTitle("Medication", for: .normal)
    button.setTitleColor(K.AppColors.primarybg, for: .normal)
    button.addTarget(self, action: #selector(didTapMedication), for: .touchUpInside)
    return button
  }()
  
  lazy var activitiesButton: UIButton = {
    let button = UIButton(type: .system)
    button.setTitle("Activities", for: .normal)
    button.setTitleColor(K.AppColors.textSecondary, for: .normal)
    button.addTarget(self, action: #selector(didTapActivities), for: .touchUpInside)
    return button
  }()
  
  let lineView1 = UIView()
  let lineView2 = UIView()
  
  public var tableView: UITableView = {
    let tableView = UITableView(frame: .zero, style: .plain)
    tableView.separatorStyle = .none
    tableView.estimatedRowHeight = 200
    tableView.rowHeight = UITableView.automaticDimension
    tableView.showsVerticalScrollIndicator = false
    return tableView
  }()
  
  private var buttonStack: UIStackView!
  private var toggleStack: UIStackView!
  
  private var isMedicationSelected = true {
    didSet {
      updateToggleState()
      tableView.reloadData()
    }
  }
  
  override func viewDidLoad() {
    super.viewDidLoad()
    view.backgroundColor = .white
    tableView.delegate = self
    tableView.dataSource = self
    tableView.register(MedicationTableViewCell.self)
    
    setupViews()
    updateToggleState()
  }
  
  private func setupViews() {
    breakButton.backgroundColor = K.AppColors.buttonYellow
    clockOutButton.backgroundColor = K.AppColors.buttonRed
    clockInButton.addTarget(self, action: #selector(didTapClockin), for: .touchUpInside)
    breakButton.addTarget(self, action: #selector(didTapBreak), for: .touchUpInside)
    clockOutButton.addTarget(self, action: #selector(didTapClockout), for: .touchUpInside)
    
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
    buttonStack = HorizontalStack(arrangedSubviews: [breakButton, spaceView, clockOutButton], spacing: 20)
    buttonStack.distribution = .fillProportionally
    view.addSubview(buttonStack)
    buttonStack.newAnchor(top: headerStack.bottomAnchor, left: view.leftAnchor, right: view.rightAnchor, paddingTop: 25, paddingLeft: 20, paddingRight: 20)
    buttonStack.hide()
    
    toggleStack = HorizontalStack(arrangedSubviews: [medicationButton, activitiesButton], spacing: 20)
    toggleStack.distribution = .fillEqually
    view.addSubview(toggleStack)
    toggleStack.newAnchor(top: clockInButton.bottomAnchor, left: view.leftAnchor, right: view.rightAnchor, paddingTop: 30, paddingLeft: 20, paddingRight: 20)
    
    lineView1.backgroundColor = K.AppColors.primarybg
    lineView2.backgroundColor = K.AppColors.textSecondary
    view.addSubview(lineView1)
    lineView1.newAnchor(top: toggleStack.bottomAnchor, left: view.leftAnchor, right: medicationButton.rightAnchor, paddingTop: 5, paddingLeft: 20, height: 2)
    view.addSubview(lineView2)
    lineView2.newAnchor(top: toggleStack.bottomAnchor, left: activitiesButton.leftAnchor, right: view.rightAnchor, paddingTop: 5, paddingRight: 20, height: 2)
    
    view.addSubview(tableView)
    tableView.newAnchor(top: lineView1.bottomAnchor, left: view.leftAnchor, bottom: view.bottomAnchor, right: view.rightAnchor, paddingTop: 20, paddingLeft: 20, paddingRight: 20)
  }
  
  private func updateToggleState() {
    let selectedColor = K.AppColors.primarybg
    let unselectedColor = K.AppColors.textSecondary
    if isMedicationSelected {
      medicationButton.setTitleColor(selectedColor, for: .normal)
      activitiesButton.setTitleColor(unselectedColor, for: .normal)
      lineView1.backgroundColor = selectedColor
      lineView2.backgroundColor = unselectedColor
    } else {
      medicationButton.setTitleColor(unselectedColor, for: .normal)
      activitiesButton.setTitleColor(selectedColor, for: .normal)
      lineView1.backgroundColor = unselectedColor
      lineView2.backgroundColor = selectedColor
    }
  }
  
  // MARK: - Actions
  @objc func didTapClockin() {
    clockInButton.hide()
    buttonStack.show()
  }
  
  @objc func didTapBreak() {
    buttonStack.hide()
    clockInButton.show()
  }
  
  @objc func didTapClockout() {
    buttonStack.hide()
    clockInButton.show()
  }
  
  @objc func didTapMedication() {
    isMedicationSelected = true
  }
  
  @objc func didTapActivities() {
    isMedicationSelected = false
  }
}

// MARK: - extension
extension HomeViewController: UITableViewDelegate, UITableViewDataSource {
  public func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
    return isMedicationSelected ? viewModel.medications.count : viewModel.activities.count
  }
  
  public func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
    let cell = tableView.dequeue(MedicationTableViewCell.self, indexPath)
    let meds = isMedicationSelected ? viewModel.medications[indexPath.row] : viewModel.activities[indexPath.row]
    cell.configure(with: meds)
    return cell
  }
}
