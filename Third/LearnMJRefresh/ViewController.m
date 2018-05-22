//
//  ViewController.m
//  LearnMJRefresh
//
//  Created by 朱献国 on 2018/5/10.
//  Copyright © 2018年 feizhu. All rights reserved.
//

#import "ViewController.h"
#import "IMJRefreshNormalHeader.h"

@interface ViewController ()
@property (weak  , nonatomic) IBOutlet UIScrollView *myScrollView;
@property (nonatomic, strong) IMJRefreshNormalHeader *refreshComponent;
@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
//    self.myScrollView.contentInset = UIEdgeInsetsMake(120, 0, 0, 0);
    self.myScrollView.contentSize = CGSizeMake(SCREEN_WIDTH, SCREEN_HEIGHT * 2);
    [self.myScrollView addSubview:self.refreshComponent];
    NSLog(@"%@", NSStringFromCGRect(self.refreshComponent.frame));
    
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(3 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        [self.refreshComponent endRefreshing];
    });
}

- (IMJRefreshNormalHeader *)refreshComponent {
    if (!_refreshComponent) {
        _refreshComponent = [[IMJRefreshNormalHeader alloc] init];
        _refreshComponent.automaticallyChangeAlpha = YES;
    }
    return _refreshComponent;
}

@end
