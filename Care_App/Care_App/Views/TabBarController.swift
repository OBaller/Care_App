// TabBarController.swift
// Care_App
//
// Created by Naseem Oyebola on 17/06/2024.
//

import UIKit

class TabBarController: UITabBarController {

    private let lineView = UIView()

    override func viewDidLoad() {
        super.viewDidLoad()

        let homeVC = HomeViewController()
        let searchVC = SearchViewController()
        let accountVC = AccountViewController()

        homeVC.tabBarItem = UITabBarItem(title: "Home", image: UIImage(systemName: "house.fill"), tag: 0)
        searchVC.tabBarItem = UITabBarItem(title: "Search", image: UIImage(systemName: "magnifyingglass"), tag: 1)
        accountVC.tabBarItem = UITabBarItem(title: "Account", image: UIImage(systemName: "person.crop.circle"), tag: 2)

        self.viewControllers = [homeVC, searchVC, accountVC]

        if let items = self.tabBar.items {
            for item in items {
                item.titlePositionAdjustment = UIOffset(horizontal: 0, vertical: -4)
                item.imageInsets = UIEdgeInsets(top: -2, left: 0, bottom: 2, right: 0)
            }
        }

        self.selectedIndex = 0
        self.tabBar.tintColor = K.AppColors.primarybg
        
        setupLineView()
    }
    
    private func setupLineView() {
        lineView.backgroundColor = K.AppColors.primarybg
        lineView.translatesAutoresizingMaskIntoConstraints = false
        tabBar.addSubview(lineView)
        
        NSLayoutConstraint.activate([
            lineView.heightAnchor.constraint(equalToConstant: 2),
            lineView.topAnchor.constraint(equalTo: tabBar.topAnchor, constant: -10),
            lineView.widthAnchor.constraint(equalTo: tabBar.widthAnchor, multiplier: 1 / CGFloat(tabBar.items!.count)),
            lineView.leadingAnchor.constraint(equalTo: tabBar.leadingAnchor)
        ])
    }

    override func viewWillLayoutSubviews() {
        super.viewWillLayoutSubviews()
        updateLineViewPosition()
    }
    
    override func tabBar(_ tabBar: UITabBar, didSelect item: UITabBarItem) {
        updateLineViewPosition()
    }
    
    private func updateLineViewPosition() {
        guard let items = tabBar.items else { return }
        let itemIndex = CGFloat(selectedIndex)
        let itemWidth = tabBar.frame.width / CGFloat(items.count)
        let xPosition = itemWidth * itemIndex
        
        UIView.animate(withDuration: 0.3) {
            self.lineView.frame.origin.x = xPosition
        }
    }
}
