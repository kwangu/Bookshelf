//
//  AppDelegate.swift
//  Bookshelf
//
//  Created by 강관구 on 2022/04/08.
//

import UIKit

@main
class AppDelegate: UIResponder, UIApplicationDelegate {
    var window: UIWindow?

    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        // Override point for customization after application launch.

        if window == nil {
            window = UIWindow(frame: UIScreen.main.bounds)
        }
        let rootVC = SearchViewController()
        let navVC = UINavigationController(rootViewController: rootVC)

        window?.rootViewController = navVC
        window?.makeKeyAndVisible()

        return true
    }

}
