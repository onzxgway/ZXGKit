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

@interface NewFreshViewController () <UITableViewDelegate, UITableViewDataSource>

@property (weak, nonatomic) IBOutlet UITableView *table;

@end

@implementation NewFreshViewController {
    NSInteger _cellCount;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    _cellCount = 6;
    
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithTitle:@"EndRefresh" style:UIBarButtonItemStyleDone target:self action:@selector(endRefresh)];
    
    self.table.refreshHeader = [NewRefreshNormalHeader refreshWithBlock:^{
        NSLog(@"Header Refreshing");
    }];
    
    self.table.refreshFooter = [NewRefreshBackFooter refreshWithBlock:^{
        NSLog(@"Footer Refreshing");
    }];
    
}

- (void)viewWillLayoutSubviews {
    [super viewWillLayoutSubviews];
    
    self.table.tableFooterView = [UIView new];
}

- (void)endRefresh {
    [self.table.refreshHeader endRefresh];
    [self.table.refreshFooter endRefresh];
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
