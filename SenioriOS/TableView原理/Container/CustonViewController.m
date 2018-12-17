//
//  CustonViewController.m
//  TableView原理
//
//  Created by 朱献国 on 2018/12/4.
//  Copyright © 2018年 朱献国. All rights reserved.
//

#import "CustonViewController.h"
#import "CustomTableView.h"
#import "CustomTableViewCell.h"

@interface CustonViewController () <CustonTableViewDataSource>

@end

@implementation CustonViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
    
    CustomTableView *tb = [[CustomTableView alloc] initWithFrame:CGRectMake(0, 0, self.view.bounds.size.width, self.view.bounds.size.height)];
    tb.dataSource = self;
    [self.view addSubview:tb];
    [tb reloadData];
}

- (NSInteger)tableView:(CustomTableView *)tableView numberOfRowsInSection:(NSInteger)section {
    NSLog(@"%s", __func__);
    return 20;
}

- (CustomTableViewCell *)tableView:(CustomTableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    NSLog(@"%s %zd__%zd", __func__, indexPath.section, indexPath.row);
    CustomTableViewCell *cell = [[CustomTableViewCell alloc] init];
    if (indexPath.row % 2) {
        cell.backgroundColor = [UIColor yellowColor];
    }
    else {
        cell.backgroundColor = [UIColor blueColor];
    }
    return cell;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    NSLog(@"%s %zd__%zd", __func__, indexPath.section, indexPath.row);
    return 88.f;
}

@end
