//
//  SceneDelegate.swift
//  FreeNowTest
//
//  Created by Shibanee Mishra on 08/07/22.
//

import UIKit

class SceneDelegate: UIResponder, UIWindowSceneDelegate {

    var window: UIWindow?


    func scene(_ scene: UIScene, willConnectTo session: UISceneSession, options connectionOptions: UIScene.ConnectionOptions) {
        guard let _ = (scene as? UIWindowScene) else { return }
        let controller = VehicleListController.getInstance()
        let centerNavVC = UINavigationController(rootViewController: controller)
        window?.rootViewController = centerNavVC
        centerNavVC.setNavigationBarHidden(true, animated: true)
        UIView.transition(with: window!, duration: 0.3,
                          options: .transitionFlipFromLeft,
                          animations: {}, completion: nil)
        centerNavVC.setNavigationBarHidden(true, animated: true)


    }

  

}

