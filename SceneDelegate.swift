//
//  SceneDelegate.swift
//  CityMarks
//
//  Created by André Emiliano on 26/11/2023.
//

import UIKit

class SceneDelegate: UIResponder, UIWindowSceneDelegate {

    var window: UIWindow?

    func scene(_ scene: UIScene, willConnectTo session: UISceneSession, options connectionOptions: UIScene.ConnectionOptions) {
        guard let windowScene = (scene as? UIWindowScene) else { return }
        
        let window = UIWindow(windowScene: windowScene)
        let viewModel = MainViewModel()
        window.rootViewController = MainViewController(viewModel: viewModel)
        window.makeKeyAndVisible()
        self.window = window
    }
}

