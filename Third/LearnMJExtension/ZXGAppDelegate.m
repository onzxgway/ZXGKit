//
//  ZXGAppDelegate.m
//  LearnMJExtension
//
//  Created by 朱献国 on 2018/5/29.
//  Copyright © 2018年 feizhu. All rights reserved.
//

#import "ZXGAppDelegate.h"
#import "ViewController.h"

@implementation ZXGAppDelegate

- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    
    self.window = [[UIWindow alloc] initWithFrame:[UIScreen mainScreen].bounds];
    
    self.window.rootViewController = [[UINavigationController alloc] initWithRootViewController:[ViewController new]];
    
    [self.window makeKeyAndVisible];
    
    return YES;
}

@end
