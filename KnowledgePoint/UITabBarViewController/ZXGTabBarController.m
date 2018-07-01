//
//  ZXGTabBarController.m
//  KnowledgePoint
//
//  Created by 朱献国 on 2018/6/25.
//  Copyright © 2018年 朱献国. All rights reserved.
//

#import "ZXGTabBarController.h"

@interface ZXGTabBarController ()

@end

@implementation ZXGTabBarController

#pragma mark - LifeCycle

- (void)viewDidLoad {
    [super viewDidLoad];
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    
    [self.navigationController setNavigationBarHidden:YES animated:YES];
}

- (void)viewWillDisappear:(BOOL)animated {
    [super viewWillDisappear:animated];
    
    [self.navigationController setNavigationBarHidden:NO animated:YES];
}

#pragma mark - CreateViews

#pragma mark - Private

#pragma mark - Public

#pragma mark - LazyLoad

#pragma mark - Network

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

@end
