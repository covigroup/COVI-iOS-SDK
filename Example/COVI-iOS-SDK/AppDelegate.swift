//
//  AppDelegate.swift
//  COVI-iOS-SDK
//
//  Created by covi on 06/26/2024.
//  Copyright (c) 2024 covi. All rights reserved.
//

import UIKit
import FirebaseCore
import os.log

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {
    var window: UIWindow?

    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {

        FirebaseApp.configure()
        return true
    }

    func applicationWillResignActive(_ application: UIApplication) {
        NotificationCenter.default.post(name: NSNotification.Name("AppWillResignActive"), object: nil)
    }

    func applicationDidEnterBackground(_ application: UIApplication) {
        NotificationCenter.default.post(name: NSNotification.Name("AppDidEnterBackground"), object: nil)
    }

    func applicationWillEnterForeground(_ application: UIApplication) {
        NotificationCenter.default.post(name: NSNotification.Name("AppWillEnterForeground"), object: nil)
    }

    func applicationDidBecomeActive(_ application: UIApplication) {
        NotificationCenter.default.post(name: NSNotification.Name("AppDidBecomeActive"), object: nil)
    }

    func applicationWillTerminate(_ application: UIApplication) {
    }
}
