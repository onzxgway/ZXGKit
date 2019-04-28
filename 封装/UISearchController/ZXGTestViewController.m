//
//  ZXGTestViewController.m
//  UISearchController
//
//  Created by onzxgway on 2019/4/28.
//  Copyright © 2019年 朱献国. All rights reserved.
//

#import "ZXGTestViewController.h"
#import "ZXGTableViewController.h"

@interface ZXGTestViewController ()
@end

@implementation ZXGTestViewController

/**
 
 设置控制器的View从导航栏底部开始方法：
 
    1.设置导航栏的translucent = NO即可
 
 */
- (void)viewDidLoad {
    [super viewDidLoad];
    
    ZXGTableViewController *ctrl = [[ZXGTableViewController alloc] init];
    [self addChildViewController:ctrl];
    [ctrl didMoveToParentViewController:self];
    [self.view addSubview:ctrl.view];
    ctrl.view.frame = self.view.bounds;
    
    self.definesPresentationContext = YES;
}

@end
