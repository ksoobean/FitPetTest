//
//  SceneDelegate.swift
//  FitPetTest
//
//  Created by 김수빈 on 2022/04/19.
//

import UIKit

class SceneDelegate: UIResponder, UIWindowSceneDelegate {

    var window: UIWindow?


    func scene(_ scene: UIScene, willConnectTo session: UISceneSession, options connectionOptions: UIScene.ConnectionOptions) {
        guard let windowScene = (scene as? UIWindowScene) else { return }
        
        
        let window = UIWindow(windowScene: windowScene)
        window.rootViewController = UINavigationController(rootViewController: WeatherListViewController())
        window.makeKeyAndVisible()
        self.window = window
        
    }

}

