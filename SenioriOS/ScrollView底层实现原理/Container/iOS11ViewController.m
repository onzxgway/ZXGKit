//
//  iOS11ViewController.m
//  ScrollView底层实现原理
//
//  Created by onzxgway on 2019/3/26.
//  Copyright © 2019年 朱献国. All rights reserved.
//

#import "iOS11ViewController.h"

@interface iOS11ViewController () <UITableViewDelegate, UITableViewDataSource>

@end

@implementation iOS11ViewController

/**
 
 iOS11开始 废弃了 控制器的 automaticallyAdjustsScrollViewInsets 属性。使用 UIScrollView的 contentInsetAdjustmentBehavior 属性替代。
 
 1. 当 automaticallyAdjustsScrollViewInsets = YES 的时候，内容区域向下偏移 导航栏高度 + 状态栏高度 的距离。此时 scrollView.contentInset = {64, 0, 0, 0}, scrollView.contentOffset = {0, -64}。
 
 2. 当 contentInsetAdjustmentBehavior = Automatic/Always 的时候，内容区域向下偏移 导航栏高度 + 状态栏高度 的距离。此时 非刘海屏 scrollView.contentInset = {0, 0, 0, 0}, scrollView.contentOffset = {0, -64}, scrollView.adjustedContentInset = {64, 0, 0, 0}，  刘海屏 scrollView.contentInset = {0, 0, 0, 0}, scrollView.contentOffset = {0, -88}, scrollView.adjustedContentInset = {88, 0, 34, 0}
 */
- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor lightGrayColor];
    
    UITableView *table = [[UITableView alloc] initWithFrame:self.view.bounds style:UITableViewStylePlain];
    table.delegate = self;
    table.dataSource = self;
    UIView *view = [[UIView alloc] init];
    table.tableFooterView = view;
    [self.view addSubview:table];
    if (@available(iOS 11.0, *)) {
        table.contentInsetAdjustmentBehavior = UIScrollViewContentInsetAdjustmentAutomatic;
    }
    else {
        self.automaticallyAdjustsScrollViewInsets = YES;
    }
}

#pragma mark - tableView delegate && datasource method
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return 6;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"8pm"];
    if (!cell) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"8pm"];
    }
    cell.contentView.backgroundColor = [UIColor blueColor];
    return cell;
}

- (void)scrollViewDidScroll:(UIScrollView *)scrollView {
    
    NSLog(@"__scrollView.contentInset: %@__", NSStringFromUIEdgeInsets(scrollView.contentInset));
    
    if (@available(iOS 11.0, *)) {
        NSLog(@"==scrollView.adjustedContentInset: %@==", NSStringFromUIEdgeInsets(scrollView.adjustedContentInset));
    }
    
    NSLog(@"++scrollView.contentOffset: %@++", NSStringFromCGPoint(scrollView.contentOffset));
    
}

@end
