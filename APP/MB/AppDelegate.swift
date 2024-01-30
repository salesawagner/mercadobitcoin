//
//  AppDelegate.swift
//  mb
//
//  Created by Wagner Sales on 29/01/24.
//

import UIKit
import API

@main
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?

    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {

        window = UIWindow()

        let api = WASAPI(environment: Environment.local)
        let viewController = ExchangesViewController.create(with: ExchangesViewModel(api: api))
        let navigationController = UINavigationController(rootViewController: viewController)

        window?.rootViewController = navigationController
        window?.makeKeyAndVisible()
        window?.backgroundColor = .black

        // Navigation bar appearance
        let navAppearance = UINavigationBar.appearance()
        navAppearance.barTintColor = .white
        navAppearance.isTranslucent = false

        return true
    }
}
