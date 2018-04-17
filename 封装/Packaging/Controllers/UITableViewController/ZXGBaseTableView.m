//
//  ZXGBaseTableView.m
//  封装
//
//  Created by 朱献国 on 2018/4/17.
//Copyright © 2018年 朱献国. All rights reserved.
//

#import "ZXGBaseTableView.h"

@interface ZXGBaseTableView ()

@end

@implementation ZXGBaseTableView

#pragma mark - lifeCycle
- (instancetype)initWithFrame:(CGRect)frame style:(UITableViewStyle)style {
    self = [super initWithFrame:frame style:style];
    if (self) {
        [self initUI];
    }
    return self;
}

- (instancetype)initWithCoder:(NSCoder *)coder {
    self = [super initWithCoder:coder];
    if (self) {
        [self initUI];
    }
    return self;
}

#pragma mark - createViews
#pragma mark - private
- (void)initUI {
    self.delegate = self;
    self.dataSource = self;
    self.separatorStyle = UITableViewCellSeparatorStyleNone;
}

#pragma mark - public
#pragma mark - lazyLoad

#pragma mark - UITableViewDataSource
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return _dataSourceArr.count;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    [_dataSourceArr objectAtIndex:section];
    return 0;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    return nil;
}

#pragma mark - UITableViewDelegate

@end
