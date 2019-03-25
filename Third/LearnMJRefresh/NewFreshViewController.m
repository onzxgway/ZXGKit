//
//  NewFreshViewController.m
//  LearnMJRefresh
//
//  Created by 朱献国 on 2019/3/21.
//  Copyright © 2019年 feizhu. All rights reserved.
//

#import "NewFreshViewController.h"
#import "NewRefreshHeader.h"
#import "NewRefreshStateHeader.h"
#import "NewRefreshNormalHeader.h"
#import "NewRefreshAutoFooter.h"
#import "NewRefreshBackFooter.h"
#import "NewRefreshAutoStateFooter.h"

@interface NewFreshViewController () <UITableViewDelegate, UITableViewDataSource>

@property (weak, nonatomic) IBOutlet UITableView *table;

@end

@implementation NewFreshViewController {
    NSInteger _cellCount;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    _cellCount = 26;
    
    if (@available(iOS 11.0, *)) {
        self.table.contentInsetAdjustmentBehavior = UIScrollViewContentInsetAdjustmentAlways;
    }
    
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithTitle:@"EndRefresh" style:UIBarButtonItemStyleDone target:self action:@selector(endRefresh)];
    
    self.table.refreshHeader = [NewRefreshNormalHeader refreshWithBlock:^{
        
        dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(3 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
            [self.table.refreshHeader endRefresh];
            
            _cellCount += 10;
            [self.table reloadData];
            
        });
//        NSLog(@"Header Refreshing");
    }];
    
//    self.table.refreshFooter = [NewRefreshAutoStateFooter refreshWithBlock:^{
////        NSLog(@"Footer Refreshing");
//        dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(3 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
//            [self.table.refreshFooter endRefresh];
//
//            _cellCount += 10;
//            [self.table reloadData];
//        });
//    }];
    
}

- (void)viewWillLayoutSubviews {
    [super viewWillLayoutSubviews];
    
    self.table.tableFooterView = [UIView new];
//    self.table.contentInset = UIEdgeInsetsMake(166, 0, 0, 0);
}

- (void)endRefresh {
//    [self.table.refreshHeader endRefresh];
//    [self.table.refreshFooter endRefresh];
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return _cellCount;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    return [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"ReuseId"];
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    _cellCount += 20;
    [self.table reloadData];
}

@end
