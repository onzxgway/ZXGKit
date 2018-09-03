//
//  AppDelegate.swift
//  XiMaLaYa
//
//  Created by 朱献国 on 2018/6/23.
//  Copyright © 2018年 朱献国. All rights reserved.
//

import UIKit

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?

    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplicationLaunchOptionsKey: Any]?) -> Bool {
        
        window = UIWindow(frame: UIScreen.main.bounds)
        
        window?.rootViewController = MainTabBarController()
        
        window?.makeKeyAndVisible()
    
        return true
    }

}

