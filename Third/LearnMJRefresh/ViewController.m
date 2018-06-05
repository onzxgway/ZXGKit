//
//  ViewController.m
//  LearnMJRefresh
//
//  Created by 朱献国 on 2018/5/10.
//  Copyright © 2018年 feizhu. All rights reserved.
//

#import "ViewController.h"
#import "IMJRefreshNormalHeader.h"
#import "MJRefreshNormalHeader.h"
#import "UIScrollView+MJRefresh.h"
#import "OneRefreshHeaderState.h"

@interface ViewController ()
@property (weak  , nonatomic) IBOutlet UIScrollView *myScrollView;
@property (weak  , nonatomic) IBOutlet UIView *topView;
@property (strong, nonatomic) OneRefreshHeaderState *refreshComponent;
@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithTitle:@"END" style:UIBarButtonItemStyleDone target:self action:@selector(end)];
    
    self.myScrollView.contentInset = UIEdgeInsetsMake(128, 0, 0, 0);
    self.myScrollView.contentSize = CGSizeMake(SCREEN_WIDTH, SCREEN_HEIGHT * 2);
    [self.myScrollView addSubview:self.refreshComponent];
//    self.myScrollView.mj_header = [MJRefreshNormalHeader headerWithRefreshingTarget:self refreshingAction:@selector(refresh)];
}

- (void)end {
//    [self.myScrollView.mj_header endRefresh];
    [self.refreshComponent endRefresh];
}

- (void)refresh {
//    [self.refreshComponent endRefresh];
}

- (OneRefreshHeaderState *)refreshComponent {
    if (!_refreshComponent) {
        _refreshComponent = [[OneRefreshHeaderState alloc] init];
//        _refreshComponent.automaticallyChangeAlpha = YES;
//        _refreshComponent.lastUpdatedTimeLabel.hidden = YES;
    }
    return _refreshComponent;
}

/**
 思路:
 1.刷新指示器 是个 控件UIView, 有3种状态.
 2.监听scrollView的contentOffsetY来实现状态的切换.
 3.不同状态对应不同的子控件.
 */

@end
