//
//  AppDelegate.swift
//  Jet2
//
//  Created by Rahul Varma on 07/07/20.
//  Copyright © 2020 Rahul Varma. All rights reserved.
//

import UIKit

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?

    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        // Override point for customization after application launch.
        ConnectionCheck.shared.startMonitoring()
        return true
    }
}
