//
//  ViewController.m
//  LearnMJRefresh
//
//  Created by 朱献国 on 2018/5/10.
//  Copyright © 2018年 feizhu. All rights reserved.
//

#import "ViewController.h"
#import "IMJRefreshNormalHeader.h"
#import "MJRefreshStateHeader.h"

@interface ViewController ()
@property (weak  , nonatomic) IBOutlet UIScrollView *myScrollView;
@property (nonatomic, strong) MJRefreshStateHeader *refreshComponent;
@property (weak, nonatomic) IBOutlet UIView *topView;
@end

@implementation ViewController



- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithTitle:@"END" style:UIBarButtonItemStyleDone target:self action:@selector(end)];
    
    self.myScrollView.contentInset = UIEdgeInsetsMake(128, 0, 0, 0);
    self.myScrollView.contentSize = CGSizeMake(SCREEN_WIDTH, SCREEN_HEIGHT * 2);
    [self.myScrollView addSubview:self.refreshComponent];
    NSLog(@"%@", NSStringFromCGRect(self.refreshComponent.frame));
}

- (void)end {
    [self.refreshComponent endRefresh];
}

- (MJRefreshStateHeader *)refreshComponent {
    if (!_refreshComponent) {
        _refreshComponent = [[MJRefreshStateHeader alloc] init];
        _refreshComponent.automaticallyChangeAlpha = YES;
    }
    return _refreshComponent;
}



@end
