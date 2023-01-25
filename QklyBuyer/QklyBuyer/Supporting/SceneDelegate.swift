//
//  SceneDelegate.swift
//  QklyBuyer
//
//  Created by arun sah on 18/01/2023.
//

import UIKit

class SceneDelegate: UIResponder, UIWindowSceneDelegate {

    var window: UIWindow?
    /// The app launcher
    let appLaunchBuilder = AppLaunchBuilder.default


    func scene(_ scene: UIScene, willConnectTo session: UISceneSession, options connectionOptions: UIScene.ConnectionOptions) {
        guard let windowScene = (scene as? UIWindowScene) else { return }
        if window == nil { window = UIWindow(windowScene: windowScene) }
        appLaunchBuilder.generateApplicationState(with: window)
    }

    func sceneDidDisconnect(_ scene: UIScene) {   }

    func sceneDidBecomeActive(_ scene: UIScene) {  }

    func sceneWillResignActive(_ scene: UIScene) {  }

    func sceneWillEnterForeground(_ scene: UIScene) {   }

    func sceneDidEnterBackground(_ scene: UIScene) {  }
    
 

}

