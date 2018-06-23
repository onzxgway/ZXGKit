//
//  ScrollViewController.m
//  Third
//
//  Created by 朱献国 on 2018/6/22.
//  Copyright © 2018年 feizhu. All rights reserved.
//

#import "ScrollViewController.h"

@interface ScrollViewController ()
@property (nonatomic, strong) UIScrollView *scrollView; // <#备注#>
@property (nonatomic, strong) UIView *redView; // <#备注#>
@property (nonatomic, strong) UIView *blueView; // 备注
@property (nonatomic, strong) UIView *greenView; // <#备注#>
@property (nonatomic, strong) UIView *containerView;
@end

@implementation ScrollViewController

#pragma mark - LifeCycle

/**
 scrollView自动计算contentSize的触发条件:
 1. 子控件参考scrollView的 左右 边做约束 且子控件本身有宽度. scrollView会自动计算 contentSize.x
 2. 子控件参考scrollView的 上下 边做约束 且子控件本身有高度. scrollView会自动计算 contentSize.y
 3. 子控件参考scrollView的 上下左右 边做约束 且子控件本身有宽度和高度. scrollView会自动计算 contentSize
 */

/**
 在自动布局 之前\之后 设置了contentSize的话
 
 1.使用Masonry在内部自动布局子控件的话,,由于scrollView会自动计算contentSize的特性,导致设置的contentSize会失效.
 
 2.
 */

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.view.backgroundColor = [UIColor whiteColor];
    
    // 提前设置好UIScrollView的contentSize，并设置UIScrollView自身的约束
//    self.scrollView.contentSize = CGSizeMake(1000, 1000);
    
    [self.view addSubview:self.scrollView];
    [self.scrollView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.mas_equalTo(self.view);
    }];
    
    [self.scrollView addSubview:self.redView];
    [self.redView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.top.equalTo(self.scrollView);
        make.width.height.mas_equalTo(200);
    }];

    [self.scrollView addSubview:self.blueView];
    [self.blueView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.redView.mas_right);
        make.top.equalTo(self.scrollView);
        make.size.equalTo(self.redView);
    }];

    [self.scrollView addSubview:self.greenView];
    [self.greenView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.scrollView);
        make.top.equalTo(self.redView.mas_bottom);
        make.size.equalTo(self.redView);
    }];
    
    
    /**
    CGFloat padding = 12;
    [self.scrollView addSubview:self.containerView];
    [self.containerView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.equalTo(self.scrollView).insets(UIEdgeInsetsMake(padding, padding, padding, padding));
    }];
    
    [self.containerView addSubview:self.greenView];
    [self.greenView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.left.equalTo(self.containerView).offset(0);
        make.size.mas_equalTo(CGSizeMake(255, 255));
    }];
    
    [self.containerView addSubview:self.redView];
    [self.redView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.containerView).offset(0);
        make.left.equalTo(self.greenView.mas_right).offset(padding);
        make.size.equalTo(self.greenView);
        make.right.equalTo(self.containerView).offset(0);
    }];
    
    [self.containerView addSubview:self.blueView];
    [self.blueView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.containerView).offset(0);
        make.top.equalTo(self.greenView.mas_bottom).offset(padding);
        make.size.equalTo(self.greenView);
        make.bottom.equalTo(self.containerView).offset(0);
    }];
     */

}

#pragma mark - CreateViews

#pragma mark - Private

#pragma mark - Public

#pragma mark - LazyLoad
- (UIScrollView *)scrollView {
    if (!_scrollView) {
        _scrollView = [[UIScrollView alloc] init];
        [self.view addSubview:_scrollView];
        _scrollView.backgroundColor = [UIColor lightGrayColor];
    }
    return _scrollView;
}

- (UIView *)redView {
    if (!_redView) {
        _redView = [[UIView alloc] init];
        _redView.backgroundColor = [UIColor redColor];
    }
    return _redView;
}

- (UIView *)blueView {
    if (!_blueView) {
        _blueView = [[UIView alloc] init];
        _blueView.backgroundColor = [UIColor blueColor];
    }
    return _blueView;
}

- (UIView *)greenView {
    if (!_greenView) {
        _greenView = [[UIView alloc] init];
        _greenView.backgroundColor = [UIColor greenColor];
    }
    return _greenView;
}

- (UIView *)containerView {
    if (!_containerView) {
        _containerView = [[UIView alloc] init];
        _containerView.backgroundColor = [UIColor darkGrayColor];
    }
    return _containerView;
}

#pragma mark - Network



@end
