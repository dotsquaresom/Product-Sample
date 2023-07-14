//
//  SceneDelegate.swift
//  Product Sample
//
//  Created by OmPrakash Jangid on 13/07/23.
//

import UIKit

class SceneDelegate: UIResponder, UIWindowSceneDelegate {

    var window: UIWindow?

    func scene(_ scene: UIScene, willConnectTo session: UISceneSession, options connectionOptions: UIScene.ConnectionOptions) {
        
        //MARK: - For set lightmode
        
        window?.overrideUserInterfaceStyle = .light
        
        //MARK: - Redirection to dashboard
        
        let nav1 = UINavigationController()
        let mainView = ProductsVC(nibName: "ProductsVC", bundle: nil)
        nav1.viewControllers = [mainView]
        self.window?.rootViewController = nav1
        self.window?.makeKeyAndVisible()
        
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

