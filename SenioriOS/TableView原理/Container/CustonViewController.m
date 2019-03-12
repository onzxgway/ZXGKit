//
//  CustonViewController.m
//  TableView原理
//
//  Created by 朱献国 on 2018/12/4.
//  Copyright © 2018年 朱献国. All rights reserved.
//

#import "CustonViewController.h"
#import "ZXGTableView.h"

@interface CustonViewController () <ZXGTableViewDataSource>

@end

@implementation CustonViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];

    
    ZXGTableView *tableView = [[ZXGTableView alloc] initWithFrame:CGRectMake(0, 0, self.view.bounds.size.width, self.view.bounds.size.height)];
    [self.view addSubview:tableView];
    tableView.dataSource = self;
    [tableView reloadData];
}

- (NSInteger)tableView:(ZXGTableView *)tableView numberOfRowsInSection:(NSInteger)section {
    NSLog(@"%s", __func__);
    return 26;
}

- (CustomTableViewCell *)tableView:(ZXGTableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    NSLog(@"%s %zd__%zd", __func__, indexPath.section, indexPath.row);
    CustomTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cell"];
    if (!cell) {
        cell = [[CustomTableViewCell alloc] initWithReuseIdentifier:@"cell"];
    }
    
    if (indexPath.row % 2) {
        cell.backgroundColor = [UIColor yellowColor];
    }
    else {
        cell.backgroundColor = [UIColor blueColor];
    }
    cell.textLabel.text = [@(indexPath.row) description];
    
    return cell;
}

- (CGFloat)tableView:(ZXGTableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    NSLog(@"%s %zd__%zd", __func__, indexPath.section, indexPath.row);
    return 18.f;
}

@end
