//
//  AppDelegate.m
//  UIWindow
//
//  Created by feizhu on 2018/3/20.
//  Copyright © 2018年 朱献国. All rights reserved.
//

#import "AppDelegate.h"
#import "ViewController.h"
#import "ZXGWindow.h"
#import "ZXGCommonKit.h"

@interface AppDelegate ()

@end

@implementation AppDelegate


/**
 UIWindow是最顶层的界面容器。
 它并不包含任何默认的内容，但是他被当作UIView的容器，用于放置应用中所有的View。当然，你也可以用UIView来当作其他UIView的容器，所以更多时候UIWindow是作为View的最顶层的容器而存在的。

 它的作用：
    1.作为View的最顶层的容器，放置应用中所有的View。
    2.传递触摸事件 和 键盘事件 给View。
 */
- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {

    self.window = [[UIWindow alloc] initWithFrame:[UIScreen mainScreen].bounds];

    self.window.rootViewController = [[UINavigationController alloc] initWithRootViewController:[[ViewController alloc] init]];

    [self.window makeKeyAndVisible];
    return YES;
}


- (void)applicationWillResignActive:(UIApplication *)application {
    // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
    // Use this method to pause ongoing tasks, disable timers, and invalidate graphics rendering callbacks. Games should use this method to pause the game.
}


- (void)applicationDidEnterBackground:(UIApplication *)application {
    // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
    // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
}

// app启动的时候，不走这个方法
- (void)applicationWillEnterForeground:(UIApplication *)application {
    // Called as part of the transition from the background to the active state; here you can undo many of the changes made on entering the background.

    [[ZXGWindow sharedWindow] show];
}


- (void)applicationDidBecomeActive:(UIApplication *)application {
    // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.

    self.littleW = [[UIWindow alloc] initWithFrame:CGRectMake(50, 150, 180, 66)];
    self.littleW.windowLevel = UIWindowLevelStatusBar;
    self.littleW.backgroundColor = kRandomColor;
    self.littleW.hidden = NO;
}


- (void)applicationWillTerminate:(UIApplication *)application {
    // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
}


@end
