//
//  main.swift
//  SwiftTour
//
//  Created by 朱献国 on 2018/10/9.
//  Copyright © 2018年 朱献国. All rights reserved.
//

import UIKit

/**
 为什么要自定义main文件呢？
 
 可以在 window之前 截获系统触摸事件 并处理
 
 底层事件传递：
 
 UIApplication -> AppDelegate -> Window -> view
 
 */
class MyApplication: UIApplication {
    
    
}

//UIApplicationMain(1, nil, nil, NSStringFromClass(AppDelegate.self))

UIApplicationMain(1, nil, NSStringFromClass(MyApplication.self), NSStringFromClass(MyAppDelegate.self))
