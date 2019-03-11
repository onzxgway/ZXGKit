//
//  CustomScrollViewController.m
//  ScrollView底层实现原理
//
//  Created by 朱献国 on 2018/11/30.
//  Copyright © 2018年 朱献国. All rights reserved.
//

#import "CustomScrollViewController.h"
#import "ZXGScrollView.h"
#import "CustomScrollView.h"

@interface CustomScrollViewController ()

@end

@implementation CustomScrollViewController

/**
 
 ScrollView底层实现原理:
 
 分析： 1. 继承自UIView， 而UIView并不能滑动，扩展边界。
 
 结论：滚动是因为 bounds.origin 的不断修改。
 
 滑动原理：
    ScrollView通过自身的Pan拖拽手势，可以获取手势移动的方向和距离，然后根据 移动的方向和距离 再去修改 自身的bounds.origin值。
 */
- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.view.backgroundColor = [UIColor whiteColor];
    
    /**
     模拟系统UIScrollView,实现自定义的控件。
     */
    CustomScrollView *scrollView = [[CustomScrollView alloc] initWithFrame:CGRectMake(110.f, [UIApplication sharedApplication].statusBarFrame.size.height + self.navigationController.navigationBar.bounds.size.height + 322.f, 140, 150.f)];
    scrollView.contentSize = CGSizeMake(scrollView.frame.size.width * 2, scrollView.frame.size.height * 2);
    scrollView.backgroundColor = [UIColor redColor];
    [self.view addSubview:scrollView];
    
    ///添加子view
    UIView *blueView = [[UIView alloc] initWithFrame:CGRectMake(50.f, 20.f, 40.f, 40.f)];
    blueView.backgroundColor = [UIColor blueColor];
    [scrollView addSubview:blueView];
}


@end
