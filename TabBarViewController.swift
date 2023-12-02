//
//  TabBarViewController.swift
//  CityMarks
//
//  Created by André Emiliano on 27/11/2023.
//

import UIKit

class TabBarViewController: UITabBarController {
    private var subViewControllers: [UINavigationController] = []
    private let homeViewModel = HomeViewModel()
    private let mapViewModel = MapViewModel()

    override func viewDidLoad() {
        super.viewDidLoad()
        self.setUpTab()
    }

    private func setUpTab() {
        UITabBar.appearance().backgroundColor = .white
        UITabBar.appearance().tintColor = .black
        let homeViewController = HomeViewController(viewModel: self.homeViewModel)
        let homeNavigationController = UINavigationController(rootViewController: homeViewController)
        let mapViewController = MapViewController(viewModel: self.mapViewModel)
        let mapNavigationController = UINavigationController(rootViewController: mapViewController)

        self.subViewControllers.append(homeNavigationController)
        self.subViewControllers.append(mapNavigationController)

        homeNavigationController.tabBarItem = UITabBarItem(title: "Home",
                                                           image: UIImage(systemName: "house"),
                                                           selectedImage: UIImage(systemName: "house.fill"))
        
        mapNavigationController.tabBarItem = UITabBarItem(title: "Map",
                                                          image: UIImage(systemName: "mappin.circle"),
                                                          selectedImage: UIImage(systemName: "mappin.circle.fill"))

        self.setViewControllers(subViewControllers, animated: true)
        self.selectedViewController = homeNavigationController
    }
}

