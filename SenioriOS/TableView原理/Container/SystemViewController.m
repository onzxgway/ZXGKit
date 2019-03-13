//
//  SystemViewController.m
//  TableView原理
//
//  Created by 朱献国 on 2018/12/4.
//  Copyright © 2018年 朱献国. All rights reserved.
//

#import "SystemViewController.h"

@interface SystemViewController () <UITableViewDelegate, UITableViewDataSource>

@end

@implementation SystemViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
    
    UITableView *tb = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, self.view.bounds.size.width, self.view.bounds.size.height) style:UITableViewStylePlain];
    tb.delegate = self;
    tb.dataSource = self;
    [self.view addSubview:tb];
}

/**
 
 系统UITableView加载数据的过程。
 
     iOS 11.0 之前的数据源方法调用顺序：
 numberOfSectionsInTableView:  ->
 tableView:numberOfRowsInSection:  ->
 遍历每一组，调用numberOfRowsInSection次tableView:heightForRowAtIndexPath:方法  ->
 tableView:cellForRowAtIndexPath: ->
 tableView:heightForRowAtIndexPath:
 
     如果 numberOfSectionsInTableView 或者 tableView:numberOfRowsInSection: 方法的返回值为0，那么 就不会再走后面的方法。
 
         1 所有cell的高度计算（ContentSize）
         2 计算当前可视范围的cell是哪些       （显示池）
         3 不在可视区域的cell，remove掉      （重用池）
 
    iOS 11.0 及之后的数据源方法调用顺序： numberOfSectionsInTableView  ->  tableView:numberOfRowsInSection: ->
 tableView:cellForRowAtIndexPath: ->
 tableView:heightForRowAtIndexPath:
 
    如果 numberOfSectionsInTableView 或者 tableView:numberOfRowsInSection: 方法的返回值为0，那么 就不会再走后面的方法。
 */

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    NSLog(@"%s", __func__);
    return 2;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    NSLog(@"%s", __func__);
    return 10;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    NSLog(@"%s %zd__%zd", __func__, indexPath.section, indexPath.row);
    UITableViewCell *cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@""];
    cell.textLabel.text = [@(indexPath.row) stringValue];
    return cell;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    NSLog(@"%s %zd__%zd", __func__, indexPath.section, indexPath.row);
    return 88.f;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    [tableView reloadData];
}

@end
