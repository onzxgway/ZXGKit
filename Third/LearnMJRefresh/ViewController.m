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
#import "OneRefreshStateNormal.h"
#import "UIScrollView+OneRefresh.h"
#import "OneRefreshGifHeader.h"
#import "OneRefreshEatHeader.h"

@interface ViewController ()
@property (weak  , nonatomic) IBOutlet UIScrollView *myScrollView;
@property (weak  , nonatomic) IBOutlet UIView *topView;
@property (strong, nonatomic) OneRefreshStateNormal *refreshComponent;
@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithTitle:@"END" style:UIBarButtonItemStyleDone target:self action:@selector(end)];
    
    [self.myScrollView addObserver:self forKeyPath:@"one_Refresh" options:NSKeyValueObservingOptionNew | NSKeyValueObservingOptionOld context:nil];
    self.myScrollView.contentInset = UIEdgeInsetsMake(128, 0, 0, 0);
    self.myScrollView.contentSize = CGSizeMake(SCREEN_WIDTH, SCREEN_HEIGHT * 2);
//    [self.myScrollView addSubview:self.refreshComponent];
    self.myScrollView.one_Refresh = [OneRefreshEatHeader oneRefreshHeader:self action:@selector(refresh)];
}
- (IBAction)custom:(id)sender {
}

- (void)end {
    [self.myScrollView.one_Refresh endRefresh];
}
- (IBAction)ableEvent:(id)sender {
}

- (void)refresh {
    NSLog(@"refresh...");
}

- (void)observeValueForKeyPath:(NSString *)keyPath ofObject:(id)object change:(NSDictionary<NSKeyValueChangeKey,id> *)change context:(void *)context {
    if (STRING_EQUAL(keyPath, @"one_Refresh")) {
        NSLog(@"one_Refresh changed");
    }
}

- (OneRefreshStateNormal *)refreshComponent {
    if (!_refreshComponent) {
        _refreshComponent = [[OneRefreshStateNormal alloc] init];
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
