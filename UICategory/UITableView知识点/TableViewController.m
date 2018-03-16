//
//  ViewController.m
//  tableView
//
//  Created by 朱献国 on 09/11/2016.
//  Copyright © 2016 Tencent. All rights reserved.
//

#import "TableViewController.h"
#import "ZXGCell.h"

@interface TableViewController ()<UITableViewDataSource,UITableViewDelegate>
@property (weak, nonatomic) IBOutlet UITableView *tableView;
@end

@implementation TableViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self setupTableHeaderView];
    
    //设置组间距 方式一
//    self.tableView.sectionHeaderHeight = 3;
//    self.tableView.sectionFooterHeight = 6;
    
    //设置cell行高 方式一
//    self.tableView.rowHeight = 54;
    
//    [self setupSeparatorLine:self.tableView];
}

//去掉tableHeaderView / tableFooterView
- (void)setupTableHeaderView {
    UIView *view = [[UIView alloc] init];
    view.frame = CGRectMake(0, 0, 0, 0.1);
    self.tableView.tableFooterView = view;
}


- (void)removeLine {
    //plain样式下，如果就一组，除去不显示数据的行的多余分割线
    UIView *footerView = [[UIView alloc] init];
    footerView.frame = CGRectMake(0, 0, 0, 0.01);//添加该行代码，除去最后一个有数据的cell行的下分割线
    self.tableView.tableFooterView = footerView;
}

#pragma mark - UITableView DataSource
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 7;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return 2;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell * cell = [tableView dequeueReusableCellWithIdentifier:@"cell"];
    if (!cell) {
        cell = [[UITableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"cell"];
    }
    cell.textLabel.text = @"哈哈哈";
    //cell的分割线左侧到边 方式一
    [cell setSeparatorInset:UIEdgeInsetsMake(0, 0, 0, 0)];
    
//    [self setupSeparatorLine:cell];
    return cell;
}

//cell的分割线左侧到边 方式二
- (void)setupSeparatorLine:(UIView *)targetView {
    NSValue *value = [NSValue valueWithUIEdgeInsets:UIEdgeInsetsMake(0, 0, 0, 0)];
    [targetView setValue:value forKey:@"separatorInset"];
    [targetView setValue:value forKey:@"layoutMargins"];
}

#pragma mark - UITableView Delegate
//设置cell行高 方式二
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 54;
}


//设置组间距 方式二
- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section {
    return 3;
}

- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section {
    return 6;
}

//设置组头视图和组尾视图
- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section {
    
    UIView *v = [UIView new];
    //组头视图和组尾视图设置frame是无效的，他显示的高度由代理方法决定。
//    v.frame = CGRectMake(0, 0, 0, 6);
    v.backgroundColor = [UIColor redColor];
    return v;
}

- (UIView *)tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section {
    UIView *v = [UIView new];
    //组头视图和组尾视图设置frame是无效的
//    v.frame = CGRectMake(0, 0, 0, 12);
    v.backgroundColor = [UIColor blueColor];
    return v;
}


//给cell加上 点击时候的 高亮样式 手指离开 高亮消失
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
}

@end
