//
//  ViewController.m
//  TablePerformanceOptimization
//
//  Created by 朱献国 on 12/10/2017.
//  Copyright © 2017 朱献国. All rights reserved.
//

#import "TableViewController.h"
#import "DemoCell.h"
#import "YYWebImage.h"

static NSString *const cellIdentifier = @"cellIdentifier";

@interface TableViewController ()<UITableViewDataSource, UITableViewDelegate>

@end

@implementation TableViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self prepareTableView];
}


- (void)prepareTableView {
    UITableView *tableView = [[UITableView alloc] initWithFrame:self.view.bounds style:UITableViewStylePlain];
    tableView.dataSource = self;
    tableView.delegate = self;
    
    [tableView registerClass:[DemoCell class] forCellReuseIdentifier:cellIdentifier];
    tableView.rowHeight = 100;
    [self.view addSubview:tableView];
}

#pragma mark - UITableViewDataSource
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return 100;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellIdentifier forIndexPath:indexPath];
    
    NSURL *url = [NSURL URLWithString:@"https://timgsa.baidu.com/timg?image&quality=80&size=b9999_10000&sec=1507782310360&di=67294e07e4220a7893b6c3f996ef4f12&imgtype=0&src=http%3A%2F%2Fimg.zcool.cn%2Fcommunity%2F014c2a561b242432f8755701c0ed6b.gif"];
    [cell.imageView yy_setImageWithURL:url placeholder:[UIImage imageNamed:@"place.jpg"]];
    
    return cell;
}

@end
