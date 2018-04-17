//
//  ZXGBaseTableViewController.m
//  Packaging
//
//  Created by 朱献国 on 2018/4/17.
//  Copyright © 2018年 朱献国. All rights reserved.
//

#import "ZXGBaseTableViewController.h"

@interface ZXGBaseTableViewController ()

@end

@implementation ZXGBaseTableViewController

- (void)viewDidLoad {
    [super viewDidLoad];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

#pragma mark - lifeCycle
#pragma mark - createViews
#pragma mark - private
#pragma mark - public
#pragma mark - lazyLoad
- (UITableView *)baseTableView {
    if (!_baseTableView) {
//        _baseTableView = [[ZXGBaseTableView alloc] initWithFrame:CGRectZero style:[self tableViewStyle]];
//        _baseTableView.sectionIndexColor = UIColorFromRGB(0x666666);
//        _baseTableView.sectionIndexBackgroundColor = [UIColor clearColor];
    }
    return _baseTableView;
}

@end
