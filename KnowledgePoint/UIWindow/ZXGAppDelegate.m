//
//  ZXGAppDelegate.m
//  UIWindow
//
//  Created by 朱献国 on 2018/5/29.
//  Copyright © 2018年 朱献国. All rights reserved.
//

#import "ZXGAppDelegate.h"
#import "ViewController.h"

@implementation ZXGAppDelegate

- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(nullable NSDictionary<UIApplicationLaunchOptionsKey, id> *)launchOptions {
    self.window = [[UIWindow alloc] initWithFrame:[UIScreen mainScreen].bounds];
    
    // UIWindow 添加子视图的两种方法。
    // 1.
    self.window.rootViewController = [[UINavigationController alloc] initWithRootViewController:[[ViewController alloc] init]];
    // 2. 但是在启动的时候，不可以使用这种方式，会报错。
//    UINavigationController *navCtrl = [[UINavigationController alloc] initWithRootViewController:[[ViewController alloc] init]];
//    navCtrl.view.frame = self.window.bounds;
//    [self.window addSubview:navCtrl.view];
    
    [self.window makeKeyAndVisible];
    return YES;
}

@end
