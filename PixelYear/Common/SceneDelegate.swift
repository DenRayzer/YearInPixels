//
//  SceneDelegate.swift
//  PixelYear
//
//  Created by Елизавета on 22.07.2020.
//  Copyright © 2020 Elizaveta. All rights reserved.
//

import UIKit


class SceneDelegate: UIResponder, UIWindowSceneDelegate {

    var window: UIWindow?


    func scene(_ scene: UIScene, willConnectTo session: UISceneSession, options connectionOptions: UIScene.ConnectionOptions) {

        self.window = self.window ?? UIWindow()
        var storyboardName: String
        let sensetiveDataService = SensitiveDataService()

//        if let v = sensetiveDataService.getToken() {
//            print(v)
//                  storyboardName = "Main"
//        } else { storyboardName = "Login" }
        storyboardName = "Login"

        let storyboard = UIStoryboard(name: storyboardName, bundle: .main)

        if let initialViewController = storyboard.instantiateInitialViewController() {
            window?.rootViewController = initialViewController
            window?.makeKeyAndVisible()
        }

        guard let _ = (scene as? UIWindowScene) else { return }
    }

    func sceneDidDisconnect(_ scene: UIScene) {

    }

    func sceneDidBecomeActive(_ scene: UIScene) {

    }

    func sceneWillResignActive(_ scene: UIScene) {

    }

    func sceneWillEnterForeground(_ scene: UIScene) {

    }

    func sceneDidEnterBackground(_ scene: UIScene) {
        (UIApplication.shared.delegate as? AppDelegate)?.saveContext()
    }
}

