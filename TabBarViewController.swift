//
//  TabBarViewController.swift
//  CityMarks
//
//  Created by André Emiliano on 27/11/2023.
//

import UIKit

class TabBarViewController: UITabBarController {
    var subViewControllers: [UINavigationController] = []
    let homeViewModel = HomeViewModel()

    override func viewDidLoad() {
        super.viewDidLoad()
        self.setUpTab()
    }

    private func setUpTab() {
        UITabBar.appearance().tintColor = .gray
        let homeViewController = HomeViewController(viewModel: self.homeViewModel)
        let homeNavigationController = UINavigationController(rootViewController: homeViewController)
        self.subViewControllers.append(homeNavigationController)

        homeNavigationController.tabBarItem = UITabBarItem(title: "Home",
                                         image: UIImage(systemName: "house.fill"),
                                         tag: 0)

        self.setViewControllers(subViewControllers, animated: true)
        self.selectedViewController = homeNavigationController
    }
}

