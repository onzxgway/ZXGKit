//
//  BViewController.m
//  UIWindow
//
//  Created by feizhu on 2018/3/20.
//  Copyright © 2018年 朱献国. All rights reserved.
//

#import "BViewController.h"
#import "ZXGCommonKit.h"
#import "AppDelegate.h"

@interface BViewController ()

@end

@implementation BViewController {
    UIWindow *_window;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor lightGrayColor];
    
    //
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithTitle:@"exchangeKeyWindow" style:UIBarButtonItemStylePlain target:self action:@selector(exchangeKeyWindow)];
}

- (void)exchangeKeyWindow {
    
    _window = [[UIWindow alloc] initWithFrame:[UIScreen mainScreen].bounds]; // 一旦创建好了之后，自动添加在整个界面上
    _window.windowLevel = UIWindowLevelNormal;
    _window.hidden = NO;
    _window.backgroundColor = [UIColor redColor];
    
    UIGestureRecognizer *gesture = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(hideWindow:)];
    [_window addGestureRecognizer:gesture];
}

- (void)hideWindow:(UIGestureRecognizer *)ges {
    _window.hidden = YES;
    _window = nil;
}

@end
