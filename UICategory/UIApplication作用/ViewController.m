//
//  ViewController.m
//  UIApplication作用
//
//  Created by san_xu on 2017/10/11.
//  Copyright © 2017年 朱献国. All rights reserved.
//

#import "ViewController.h"
#import "Person.h"
#import <UserNotifications/UserNotifications.h>

#define iOS_version [[UIDevice currentDevice].systemVersion floatValue]

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self applicationFuc];
}

#pragma mark - UIApplication作用
//UIApplication作用：
- (void)applicationFuc {
    //一：联网提示
    UIApplication *app = [UIApplication sharedApplication];
    [app setNetworkActivityIndicatorVisible:YES];
    
    //二：图标的提醒数字
    [app setApplicationIconBadgeNumber:36];
    
    if (iOS_version >= 10.0) {
        UNUserNotificationCenter *center = [UNUserNotificationCenter currentNotificationCenter];
        [center requestAuthorizationWithOptions:(UNAuthorizationOptionBadge) completionHandler:^(BOOL granted, NSError * _Nullable error) {}];
        
    } else {
        
        UIUserNotificationSettings *settings = [UIUserNotificationSettings settingsForTypes:UIUserNotificationTypeBadge categories:nil];
        
        [app registerUserNotificationSettings:settings];
    }
    
    //三：设置状态栏  在iOS7之后,状态栏默认交给控制器管理
    //如何让UIApplication管理？Info.plist -> View controller-based status bar appearance 设置为NO，即可。
    [app setStatusBarHidden:YES withAnimation:UIStatusBarAnimationSlide];
    [app setStatusBarStyle:UIStatusBarStyleLightContent];
    
    //四：打电话,发短信,发邮件,打开网页  根据协议头判断用什么软件打开
    // 打开网页 http://www.baidu.com
    // 拨打电话 tel://10086
    // 打开短信 sms://10086
    // 打开邮件 mailto://zhuxianguo529@163.com
    NSURL *url = [NSURL URLWithString:@"tel://10086"];
    [app openURL:url];
}

#pragma mark - UIApplication单例
- (void)application {
    //一个iOS程序启动后创建的第一个对象就是UIApplication对象
    
    // 苹果单例实现
    // 0.内部创建了单例,什么时候创建,程序启动的时候创建单例
    // 1.外界不能调用alloc,一调用就崩掉,其实就是抛异常
    // 2.提供一个方法给外界获取单例
    
    //    UIApplication *appli = [[UIApplication alloc] init]; //UIApplication不能调用alloc,一调用就崩掉
    UIApplication *app = [UIApplication sharedApplication];//只能通过该方法获取单例
    
    Person *person = [Person sharedPerson];
    NSLog(@"__%@_%@__",app,person);
}


@end
