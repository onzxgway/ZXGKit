//
//  ZXGNavigationController.m
//  KnowledgePoint
//
//  Created by 朱献国 on 2018/6/25.
//  Copyright © 2018年 朱献国. All rights reserved.
//

#import "ZXGNavigationController.h"

@interface ZXGNavigationController ()

@end

@implementation ZXGNavigationController

#pragma mark - LifeCycle

- (void)viewDidLoad {
    [super viewDidLoad];
    
    
}

#pragma mark - CreateViews

#pragma mark - Private

#pragma mark - Public

#pragma mark - LazyLoad

#pragma mark - Network

- (void)pushViewController:(UIViewController *)viewController animated:(BOOL)animated {
    
    //1.如果是非栈底控制器就隐藏底部Dock操作条
    if (self.childViewControllers.count > 0) {
        viewController.hidesBottomBarWhenPushed = YES;
        
        //设置导航栏按钮
        
        //
        viewController.automaticallyAdjustsScrollViewInsets = NO;
        
        //判断用户是否登录
    }
    
    [super pushViewController:viewController animated:animated];
}

@end
