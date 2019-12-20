//
//  AppDelegate.swift
//  twitter
//
//  Created by MacBook Pro  on 19.12.2019.
//  Copyright © 2019 MacBook Pro . All rights reserved.
//

import UIKit

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {
    
    var window: UIWindow?
    
    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        window = UIWindow(frame: UIScreen.main.bounds)
        window?.makeKeyAndVisible()
        let mainVC = MainTabViewController()
        window?.rootViewController = mainVC
        return true
    }
    
    
    
    
}

