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
        setUpTab()
    }

    private func setUpTab() {
        UITabBar.appearance().backgroundColor = .white
        UITabBar.appearance().tintColor = .black
        let homeViewController = HomeViewController(viewModel: homeViewModel)
        let homeNavigationController = UINavigationController(rootViewController: homeViewController)
        let mapViewController = MapViewController(viewModel: mapViewModel)
        let mapNavigationController = UINavigationController(rootViewController: mapViewController)

        subViewControllers.append(homeNavigationController)
        subViewControllers.append(mapNavigationController)

        homeNavigationController.tabBarItem = UITabBarItem(title: "Home",
                                                           image: UIImage(systemName: "house"),
                                                           selectedImage: UIImage(systemName: "house.fill"))
        
        mapNavigationController.tabBarItem = UITabBarItem(title: "Map",
                                                          image: UIImage(systemName: "mappin.circle"),
                                                          selectedImage: UIImage(systemName: "mappin.circle.fill"))

        setViewControllers(subViewControllers, animated: true)
        selectedViewController = homeNavigationController
    }
}

