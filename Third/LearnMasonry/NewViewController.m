//
//  NewViewController.m
//  Third
//
//  Created by 朱献国 on 2018/6/4.
//  Copyright © 2018年 feizhu. All rights reserved.
//

#import "NewViewController.h"
#import "NewTableViewCell.h"

@interface NewViewController ()
<
UITableViewDelegate,
UITableViewDataSource
>
@property (nonatomic, strong) UITableView *tableView;
@end

@implementation NewViewController

#pragma mark - LifeCycle

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = kRandomColor;
    self.automaticallyAdjustsScrollViewInsets = NO;
    
    [self.view addSubview:self.tableView];
    [self.tableView mas_makeConstraints:^(MASConstraintMaker *make) {
//        make.edges.mas_equalTo(self.view);
        make.edges.mas_equalTo(self.view).insets(UIEdgeInsetsMake(88, 22, 49, 22));
    }];
}

#pragma mark - CreateViews

#pragma mark - Private

#pragma mark - Public

#pragma mark - LazyLoad
- (UITableView *)tableView {
    if (!_tableView) {
        _tableView = [[UITableView alloc] initWithFrame:CGRectZero style:UITableViewStylePlain];
        _tableView.delegate = self;
        _tableView.dataSource = self;
        _tableView.tableFooterView = [UIView new];
        [_tableView registerClass:[NewTableViewCell class] forCellReuseIdentifier:@"cell"];
        
        _tableView.rowHeight = UITableViewAutomaticDimension;
        _tableView.estimatedRowHeight = 108;
    }
    return _tableView;
}

#pragma mark - UITableViewDataSource
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return 6;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    NewTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cell"];
    cell.contentView.backgroundColor = kRandomColor;
    cell.type = indexPath.row % 6;
    return cell;
}

@end
