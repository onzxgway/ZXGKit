//
//  LearnScrollViewController.m
//  UIKit
//
//  Created by 朱献国 on 2019/3/18.
//  Copyright © 2019年 朱献国. All rights reserved.
//

#import "LearnScrollViewController.h"

@interface LearnScrollViewController ()
@property (nonatomic, strong) UIScrollView *scrollView;
@property (nonatomic, strong) UIView *rView;
@end

@implementation LearnScrollViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.view.backgroundColor = [UIColor whiteColor];
    
    [self.view addSubview:self.scrollView];
    self.scrollView.frame = CGRectMake(38, 188, 318, 198);
    
    [self.scrollView addSubview:self.rView];
    self.rView.frame = CGRectMake(0, 0, self.scrollView.bounds.size.width * 2, self.scrollView.bounds.size.height);
    
    /**
     1.请说明并比较以下关键词：contentInset，contentSize，contentOffset。
     */
    // contentSize 指 UIScrollView 上显示内容的区域大小。
    self.scrollView.contentSize = CGSizeMake(self.scrollView.bounds.size.width * 2, self.scrollView.bounds.size.height);
    // contentInset 是指 内容区域 与 UIScrollView 的边界。指 内容区域 的四条边到 UIScrollView 的对应边的距离，分别为 top，bottom，left，right。
    self.scrollView.contentInset = UIEdgeInsetsMake(20, 20, 20, 20);
    // contentOffset 是当前 内容区域 浏览位置左上角点的坐标。它是相对于整个 UIScrollView 左上角为左边原点而言。默认为 CGPointZero。
    self.scrollView.contentOffset = CGPointMake(-20, -20);
}

- (UIScrollView *)scrollView {
    if (!_scrollView) {
        _scrollView = [[UIScrollView alloc] init];
        _scrollView.backgroundColor = [UIColor lightGrayColor];
    }
    return _scrollView;
}

- (UIView *)rView {
    if (!_rView) {
        _rView = [UIView new];
        _rView.backgroundColor = [UIColor redColor];
    }
    return _rView;
}

@end
