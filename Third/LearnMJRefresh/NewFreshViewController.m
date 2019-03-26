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

#import "GGRefreshHeader.h"
#import "GGRefreshStateHeader.h"
#import "GGRefreshNormalHeader.h"
#import "GGRefreshAutoFooter.h"
#import "GGRefreshBackFooter.h"

@interface NewFreshViewController () <UITableViewDelegate, UITableViewDataSource>

@property (weak, nonatomic) IBOutlet UITableView *table;

@end

@implementation NewFreshViewController {
    NSInteger _cellCount;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    _cellCount = 6;
    
    if (@available(iOS 11.0, *)) {
        self.table.contentInsetAdjustmentBehavior = UIScrollViewContentInsetAdjustmentNever;
    }
    else {
        self.automaticallyAdjustsScrollViewInsets = NO;
    }
    
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithTitle:@"EndRefresh" style:UIBarButtonItemStyleDone target:self action:@selector(endRefresh)];
    
    self.table.gg_headerRefresh = [GGRefreshNormalHeader refreshWithBlock:^{

        dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(2 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
            [self.table.gg_headerRefresh endRefresh];

            _cellCount = 6;
            [self.table reloadData];

        });
        
    }];
    
    self.table.gg_footerRefresh = [GGRefreshBackFooter refreshWithBlock:^{
        
        dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(2 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
            [self.table.gg_footerRefresh endRefresh];

            _cellCount += 10;
            [self.table reloadData];
            
        });
    }];
    
}

- (void)viewWillLayoutSubviews {
    [super viewWillLayoutSubviews];
    
    self.table.tableFooterView = [UIView new];
//    self.table.contentInset = UIEdgeInsetsMake(166, 0, 0, 0);
}

- (void)endRefresh {
//    [self.table.gg_headerRefresh endRefresh];
//    [self.table.gg_footerRefresh endRefresh];
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return _cellCount;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    return [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"ReuseId"];
}

//- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
//    _cellCount += 20;
//    [self.table reloadData];
//}

@end
