//
//  ViewController.m
//  ScrollView底层实现原理
//
//  Created by 朱献国 on 2018/11/30.
//  Copyright © 2018年 朱献国. All rights reserved.
//

#import "ViewController.h"
#import "CustomScrollViewController.h"
#import "TwoCustomViewController.h"
#import "SystemScrollViewController.h"

@interface ViewController () <UITableViewDelegate, UITableViewDataSource> {
    NSArray *textArr;
}
@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    textArr = @[@"自定义scrollView", @"自定义scrollView事件传递", @"系统的scrollView参照", @"contentInset的实际意义"];
    
    UITableView *table = [[UITableView alloc] initWithFrame:CGRectMake(0.f, 0.f, self.view.frame.size.width, self.view.frame.size.height) style:UITableViewStylePlain];
    table.delegate = self;
    table.dataSource = self;
    UIView *view = [[UIView alloc] init];
    table.tableFooterView = view;
    [self.view addSubview:table];
    
}

#pragma mark - tableView delegate && datasource method
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    
    return textArr.count;
    
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"8pm"];
    if (!cell) {
        
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"8pm"];
        cell.textLabel.text = textArr[indexPath.row];
    }
    
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    
    if (indexPath.row == 0) {
        
        CustomScrollViewController *scrollViewCtrl = [[CustomScrollViewController alloc] init];
        [self.navigationController pushViewController:scrollViewCtrl animated:YES];
        
    } else if (indexPath.row == 1) {
        
        TwoCustomViewController *viewCtrl = [[TwoCustomViewController alloc] init];
        [self.navigationController pushViewController:viewCtrl animated:YES];
        
    } else if (indexPath.row == 2) {
        
        SystemScrollViewController *viewCtrl = [[SystemScrollViewController alloc] init];
        [self.navigationController pushViewController:viewCtrl animated:YES];
        
    } else if (indexPath.row == 3) {
        
        SystemScrollViewController *viewCtrl = [[SystemScrollViewController alloc] init];
        [self.navigationController pushViewController:viewCtrl animated:YES];
        
    }
    
}


@end
