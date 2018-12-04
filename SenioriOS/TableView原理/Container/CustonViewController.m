//
//  CustonViewController.m
//  TableView原理
//
//  Created by 朱献国 on 2018/12/4.
//  Copyright © 2018年 朱献国. All rights reserved.
//

#import "CustonViewController.h"
#import "CustonTableView.h"
#import "CustomTableViewCell.h"

@interface CustonViewController () <CustonTableViewDataSource>

@end

@implementation CustonViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
    
    CustonTableView *tb = [[CustonTableView alloc] initWithFrame:CGRectMake(0, 0, self.view.bounds.size.width, self.view.bounds.size.height)];
    tb.dataSource = self;
    [self.view addSubview:tb];
}

- (NSInteger)tableView:(CustonTableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return 10;
}

- (CustomTableViewCell *)tableView:(CustonTableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    CustomTableViewCell *cell = [[CustomTableViewCell alloc] init];
    return cell;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return 58.f;
}

@end
