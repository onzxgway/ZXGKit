//
//  main.m
//  LaunchTheory
//
//  Created by 朱献国 on 2018/10/15.
//  Copyright © 2018年 朱献国. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "AppDelegate.h"

// main函数 应用启动入口
//int main(int argc, char * argv[]) {
//    @autoreleasepool {
//        return UIApplicationMain(argc, argv, nil, NSStringFromClass([AppDelegate class]));
//    }
//}

/**
 UIApplicationMain 作用:
 
 1.创建UIApplication对象。
 2.设置UIApplication的delegate对象。
 3.
 */
int main(int argc, char *argv[]) {
    @autoreleasepool {
        return UIApplicationMain(argc, argv, nil, NSStringFromClass(AppDelegate.class));
    }
}
