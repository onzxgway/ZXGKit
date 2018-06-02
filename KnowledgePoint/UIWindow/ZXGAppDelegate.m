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
    
    self.window.rootViewController = [[UINavigationController alloc] initWithRootViewController:[[ViewController alloc] init]];
    
    [self.window makeKeyAndVisible];
    return YES;
}

@end
